package proxy

import (
	"context"

	"github.com/bufbuild/connect-go"
	"go.uber.org/zap"
)

type loggingInterceptor struct {
	Logger *zap.SugaredLogger
}

func NewLoggingInterceptor(logger *zap.SugaredLogger) *loggingInterceptor {
	return &loggingInterceptor{
		Logger: logger,
	}
}

func (i *loggingInterceptor) WrapUnary(next connect.UnaryFunc) connect.UnaryFunc {
	return connect.UnaryFunc(func(
		ctx context.Context,
		req connect.AnyRequest,
	) (connect.AnyResponse, error) {
		name := req.Spec().Procedure
		i.Logger.Debugf("%s: req: %v", name, req.Any())
		res, err := next(ctx, req)
		if err != nil {
			i.Logger.Debugf("%s: res errored: %v", name, err)

			return nil, err
		}
		i.Logger.Debugf("%s: res: %v", name, res.Any())
		return res, nil
	})
}

func (i *loggingInterceptor) WrapStreamingClient(next connect.StreamingClientFunc) connect.StreamingClientFunc {
	return connect.StreamingClientFunc(func(
		ctx context.Context,
		spec connect.Spec,
	) connect.StreamingClientConn {
		i.Logger.DPanic("WrapStreamingClient not implemented")
		conn := next(ctx, spec)

		return conn
	})
}

func (i *loggingInterceptor) WrapStreamingHandler(next connect.StreamingHandlerFunc) connect.StreamingHandlerFunc {
	//TODO: Waiting for https://github.com/bufbuild/connect-go/issues/344d

	return connect.StreamingHandlerFunc(func(
		ctx context.Context,
		conn connect.StreamingHandlerConn,
	) error {
		name := conn.Spec().Procedure
		streamTypeStr := ""

		switch streamType := conn.Spec().StreamType; streamType {
		case connect.StreamTypeUnary:
			streamTypeStr = "Unary"
		case connect.StreamTypeClient:
			streamTypeStr = "StreamClient"
		case connect.StreamTypeServer:
			streamTypeStr = "StreamServer"
		case connect.StreamTypeBidi:
			streamTypeStr = "StreamBidi"
		}

		i.Logger.Debugf("%s, %s: req: ", name, streamTypeStr)

		return next(ctx, conn)
	})
}
