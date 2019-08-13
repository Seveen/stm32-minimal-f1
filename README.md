# Minimal LL template for STM32F1xxx

## Credits
From https://www.purplealienplanet.com/node/69 and the templates and examples in the STM32CubeF1 package documentation.

## Installation
### Clone this repo
    git clone https://gitlab.com/Seveen/stm32-minimal-f1.git
    cd stm32-minimal-f1

You need the STM32CubeF1 soft package from ST https://www.st.com/en/embedded-software/stm32cubef1.html
*Copy Drivers directory from ST soft package to ./Drivers

## Usage
### Compilation
#### Compile drivers 
    cd Drivers/
    make

#### Compile project
    make

### Flash
    st-flash --reset write project.bin 0x08000000