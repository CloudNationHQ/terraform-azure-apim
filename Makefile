.PHONY: test

export TF_PATH

test:
	cd tests && go test -v -timeout 180m -run TestApplyNoError/$(TF_PATH) ./apim_test.go
