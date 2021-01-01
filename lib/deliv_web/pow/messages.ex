defmodule DelivWeb.Pow.Messages do
  use Pow.Phoenix.Messages
  import DelivWeb.Gettext

  def invalid_credentials(_conn),
    do:
      gettext(
        "Oops. Não foi possivel fazer o login. Verifique suas credenciais e tente novamente."
      )
end
