# Pongo

**MongoDB Driver for Perl**

Pongo is a high-performance MongoDB driver for Perl, built using C and XS to provide fast, low-latency interactions with MongoDB databases. It offers full support for MongoDB's core features, including CRUD operations, querying, and indexing, while maintaining the ease of use and flexibility that Perl developers expect. With native code optimization, Pongo ensures efficient database communication, making it an ideal choice for building scalable and high-performance applications in Perl.

## Supported Versions

- **MongoDB Version**: 8.0.4
- **libmongoc Version**: 1.28.0

## Installation

### Linux

For Ubuntu/Debian-based systems, install the required dependencies:

```bash
sudo apt-get install libmongoc-1.0-0 libbson-1.0-0 libmongoc-dev libbson-dev
```

### macOS

For macOS, use Homebrew to install the necessary MongoDB C driver dependencies:

```zsh
brew install mongo-c-driver
```

### Install the Pongo Package

1. Clone the repository:

   ```bash
   git clone https://github.com/h4ck3r-04/Pongo.git
   cd Pongo
   ```

2. Build and install the package:

   ```bash
   perl Makefile.PL
   make
   sudo make install
   ```

3. To clean the build:

   ```bash
   make clean
   ```

## License

This project is licensed under the [GPL-3.0 License](LICENSE).

## Copyright

Copyright (c) 2024, Rudraditya Thakur. All rights reserved.
