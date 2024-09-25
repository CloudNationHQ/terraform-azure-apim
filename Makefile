.PHONY: test

export EXAMPLE

test:
	cd tests && go test -v -timeout 180m -run TestApplyNoError/$(EXAMPLE) ./apim_test.go
