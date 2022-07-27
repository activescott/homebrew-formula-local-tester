# homebrew formula tester

This is a local limited implementation that mimics some of the homebrew-core repo's .github/workflows/tests.yml workflow to test formulas.

To use it run  the following (where onlykey-agent is the formula name to test)

```sh
./test-1-local.sh onlykey-agent
./test-2-build-bottle-in-container-linux.sh onlykey-agent
```

I'm only testing the linux runner as it seems to be the most picky (and they all take forever).

If the container builds it's pretty much good. There are also some `container-*.sh` scripts for goofing around with the built container though too (e.g. troubleshooting or installing / testing the built formula).
