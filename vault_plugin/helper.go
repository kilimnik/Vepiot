package auth

import "strings"

func ParseList(raw interface{}) []string {
	if raw == nil {
		return []string{}
	}

	var slice []string
	switch raw.(type) {
	case string:
		if raw.(string) == "" {
			return []string{}
		}
		slice = strings.Split(raw.(string), ",")
	case []string:
		slice = raw.([]string)
	}

	return slice
}
