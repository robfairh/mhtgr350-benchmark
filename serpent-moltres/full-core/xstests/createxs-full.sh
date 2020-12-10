# Step 1: Uncomment these lines to create .coe
cp oecd-fullcore12G.coe homoge.coe
cp oecd-fullcore12G.coe irefl.coe
cp oecd-fullcore12G.coe orefl.coe
cp oecd-fullcore12G.coe brefl.coe
cp oecd-fullcore12G.coe trefl.coe
sed -i '2s/.*/1 homoge0/' homoge.coe
sed -i '2s/.*/1 irefl0/' irefl.coe
sed -i '2s/.*/1 orefl0/' orefl.coe
sed -i '2s/.*/1 brefl0/' brefl.coe
sed -i '2s/.*/1 trefl0/' trefl.coe

# Step 2: Uncomment these lines to create XS
> tempMapping
echo 'homoge0 600' >> tempMapping
echo 'irefl0 600' >> tempMapping
echo 'orefl0 600' >> tempMapping
echo 'brefl0 600' >> tempMapping
echo 'trefl0 600' >> tempMapping

> secBranch

> universeMapping
echo 'homoge 9' >> universeMapping
echo 'irefl I' >> universeMapping
echo 'orefl O' >> universeMapping
echo 'brefl B' >> universeMapping
echo 'trefl T' >> universeMapping

$MOLTRES/python/extractSerpent2GCs.py xs12 mhtgr tempMapping secBranch universeMapping

# Step 3: Uncomment these lines to remove all the unnecessary files
rm homoge.coe
rm irefl.coe
rm orefl.coe
rm brefl.coe
rm trefl.coe
rm tempMapping
rm secBranch
rm universeMapping