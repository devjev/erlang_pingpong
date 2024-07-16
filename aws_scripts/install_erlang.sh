# Dependencies
sudo yum groupinstall "Development Tools"
sudo yum install ncurses-devel openssl-devel

# Erlang/OTP
wget https://github.com/erlang/otp/releases/download/OTP-27.0.1/otp_src_27.0.1.tar.gz
tar -xzfv otp_src_27.0.1.tar.gz
rm -f otp_src_27.0.1.tar.gz
cd otp_src_27.0.1/
./configure
make
sudo make install
