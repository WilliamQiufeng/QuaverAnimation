git clone https://github.com/WilliamQiufeng/Quaver.git QuaverAnimation
cd QuaverAnimation
git checkout animation-2

git submodule set-url Quaver.API https://github.com/WilliamQiufeng/Quaver.API.git
git submodule set-branch --branch animation Quaver.API

git submodule set-url Quaver.Resources https://github.com/WilliamQiufeng/Quaver.Resources.git
git submodule set-branch --branch animation Quaver.Resources

git submodule set-url Wobble https://github.com/WilliamQiufeng/Wobble.git
git submodule set-branch --branch animation Wobble

git submodule update --init --recursive

cp ../Quaver.Shared.csproj ./Quaver.Shared/Quaver.Shared.csproj

cd Quaver.API
git checkout animation

cd ../Quaver.Resources
git checkout animation

cd ../Wobble
git checkout animation

cd ..

dotnet run --project Quaver