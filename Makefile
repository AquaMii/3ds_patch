TID_EUR = 000400300000BE02
TID_USA = 000400300000BD02
TID_JPN = 000400300000BC02

LUMA_TITLES = luma/titles

ARMIPS = armips
FLIPS  = flips

SRC    = src/main.s
BUILD  = build
OUT    = out
BIN    = code.bin
PATCH  = $(BUILD)/patched_code.bin

CERTS  = certs
CERT   = aquamii.pem

.PHONY: all clean directories patches

all: directories patches

directories:
	@mkdir -p $(BUILD)
	@mkdir -p $(OUT)/3ds
	@mkdir -p $(OUT)/$(LUMA_TITLES)/$(TID_EUR)
	@mkdir -p $(OUT)/$(LUMA_TITLES)/$(TID_USA)
	@mkdir -p $(OUT)/$(LUMA_TITLES)/$(TID_JPN)
	@cp $(CERTS)/$(CERT) $(OUT)/3ds/

patches: $(SRC)
	@echo "Assembling..."
	@$(ARMIPS) $(SRC)
	@echo "Creating patches..."
	@$(FLIPS) -c $(BIN) $(PATCH) $(OUT)/$(LUMA_TITLES)/$(TID_EUR)/code.ips
	@$(FLIPS) -c $(BIN) $(PATCH) $(OUT)/$(LUMA_TITLES)/$(TID_USA)/code.ips
	@$(FLIPS) -c $(BIN) $(PATCH) $(OUT)/$(LUMA_TITLES)/$(TID_JPN)/code.ips

clean:
	@echo "Cleaning up..."
	@rm -rf $(BUILD) $(OUT)