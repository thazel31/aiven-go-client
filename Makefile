ci: lint
.PHONY: ci

#################################################
# Bootstrapping for golangci-lint
#################################################
bootstrap:
	if [ -z "$$(which golangci-lint 2>/dev/null)" ]; then \
 	  curl -sfL https://install.goreleaser.com/github.com/golangci/golangci-lint.sh | sh -s -- -b $$(go env GOPATH)/bin; \
	fi

vendor:

update-vendor:

#################################################
# Testing and linting
#################################################

test: vendor
	CGO_ENABLED=0 go test -v ./...

lint: vendor
	golangci-lint run -D errcheck

$(LINTERS): vendor
	$(METALINT) $@

.PHONY: bootstrap test lint
