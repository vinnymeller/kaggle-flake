{
  description = "Kaggle flake template";

  outputs = { self }: {

    templates = {

      full = {
        path = ./full;
        description = "A kaggle flake providing a python environment with kaggle CLI and a bunch of machine learning packages installed";
      };

      default = self.templates.full;

    };
  };
}
