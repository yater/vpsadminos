{
  gli = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.vpsfree.cz"];
      sha256 = "1sgfc8czb7xk0sdnnz7vn61q4ixbkrpz2mkvcgchfkll94rlqhal";
      type = "gem";
    };
    version = "2.17.2";
  };
  json = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.vpsfree.cz"];
      sha256 = "0sx97bm9by389rbzv8r1f43h06xcz8vwi3h5jv074gvparql7lcx";
      type = "gem";
    };
    version = "2.2.0";
  };
  libosctl = {
    dependencies = ["require_all"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.vpsfree.cz"];
      sha256 = "17d9qyica083ns2n75bw98f00m86d16fl3npl9k7wyqrh18b7bhm";
      type = "gem";
    };
    version = "19.03.0.build20190514152849";
  };
  osup = {
    dependencies = ["gli" "json" "libosctl" "require_all"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.vpsfree.cz"];
      sha256 = "0kdpbbrb0yk96a6mcs7hqmygsbxd30frrvyxp6a42pvdi1s9dl3l";
      type = "gem";
    };
    version = "19.03.0.build20190514152849";
  };
  require_all = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.vpsfree.cz"];
      sha256 = "0sjf2vigdg4wq7z0xlw14zyhcz4992s05wgr2s58kjgin12bkmv8";
      type = "gem";
    };
    version = "2.0.0";
  };
}