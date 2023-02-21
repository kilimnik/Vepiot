package cmd

import (
	"fmt"
	"os"

	"github.com/kilimnik/vepiot/auth_proxy/proxy"
	"github.com/spf13/cobra"
	"github.com/spf13/viper"
	"go.uber.org/zap"
	"go.uber.org/zap/zapcore"
)

var rootCmd = &cobra.Command{
	Use:   "auth_proxy",
	Short: "Auth Proxy for Vepiot Hashicorp Plugin",
	Run: func(cmd *cobra.Command, args []string) {
		logger := ConfigureLogger(cmd)

		host := viper.GetString("host")
		port := viper.GetInt("port")

		server := &proxy.Server{
			Logger: logger,
			Host:   host,
			Port:   port,

			TOTPs: make(map[string]*proxy.TOTP),
		}

		server.Start()
	},
}

func init() {
	cobra.OnInitialize(initConfig)

	rootCmd.PersistentFlags().CountP("verbose", "v", "counted verbosity")
	rootCmd.PersistentFlags().Bool("no-color", false, "disable colored logging")
	rootCmd.PersistentFlags().String("log-format", "console", "logging format (console, json)")
	rootCmd.PersistentFlags().String("host", "0.0.0.0", "Host for Proxy Server")
	rootCmd.PersistentFlags().IntP("port", "p", 8080, "Port for Proxy Server")

	viper.BindPFlag("verbose", rootCmd.PersistentFlags().Lookup("verbose"))
	viper.BindPFlag("no_color", rootCmd.PersistentFlags().Lookup("no-color"))
	viper.BindPFlag("log_format", rootCmd.PersistentFlags().Lookup("log-format"))
	viper.BindPFlag("host", rootCmd.PersistentFlags().Lookup("host"))
	viper.BindPFlag("port", rootCmd.PersistentFlags().Lookup("port"))
}

func initConfig() {
	viper.SetEnvPrefix("proxy")
	viper.AutomaticEnv()

	if err := viper.ReadInConfig(); err == nil {
		fmt.Println("Using config file:", viper.ConfigFileUsed())
	}
}

func ConfigureLogger(cmd *cobra.Command) *zap.SugaredLogger {
	verbosity := viper.GetInt("verbose")
	disableColor := viper.GetBool("no_color")
	logFormat := viper.GetString("log_format")

	var logLevel = zap.WarnLevel
	if verbosity == 1 {
		logLevel = zap.InfoLevel
	} else if verbosity > 1 {
		logLevel = zap.DebugLevel
	}

	var encodeLevel = zapcore.CapitalColorLevelEncoder
	if disableColor {
		encodeLevel = zapcore.CapitalLevelEncoder
	}

	cfg := zap.Config{
		Level:       zap.NewAtomicLevelAt(logLevel),
		Development: verbosity > 0,
		Encoding:    logFormat,
		EncoderConfig: zapcore.EncoderConfig{
			// Keys can be anything except the empty string.
			TimeKey:        "T",
			LevelKey:       "L",
			NameKey:        "N",
			CallerKey:      "C",
			FunctionKey:    zapcore.OmitKey,
			MessageKey:     "M",
			StacktraceKey:  "S",
			LineEnding:     zapcore.DefaultLineEnding,
			EncodeLevel:    encodeLevel,
			EncodeTime:     zapcore.ISO8601TimeEncoder,
			EncodeDuration: zapcore.StringDurationEncoder,
			EncodeCaller:   zapcore.ShortCallerEncoder,
		},
		OutputPaths:      []string{"stdout"},
		ErrorOutputPaths: []string{"stderr"},
	}
	logger, err := cfg.Build()
	if err != nil {
		panic(err)
	}
	defer logger.Sync() // flushes buffer, if any
	sugar := logger.Sugar()

	sugar.Info("Logger Initialized")

	return sugar
}

func Execute() {
	err := rootCmd.Execute()
	if err != nil {
		os.Exit(1)
	}
}
