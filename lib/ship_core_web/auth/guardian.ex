defmodule ShipCoreWeb.Auth.Guardian do
  use Guardian, otp_app: :ship_core
  alias ShipCore.Accounts

  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :no_subject}
  end

  def resource_from_claims(%{"sub" => id}) do
    case Accounts.get_user(id) do
      nil -> {:error, :no_resource}
      user -> {:ok, user}
    end
  end

  def resource_from_claims(_) do
    {:error, :no_resource}
  end

  def authenticate(email, password) do
    case Accounts.get_account_by_email(email) do
      nil ->
        {:error, :unauthorized}

      account ->
        case validate_password(account, password) do
          true ->
            create_token(account)

          false ->
            {:error, :unauthorized}
        end
    end
  end

  defp validate_password(%{hash_password: hash_password}, password) do
      Bcrypt.verify_pass(password, hash_password)
  end

  defp create_token(account) do
    {:ok, token, _claims} = encode_and_sign(account)
    {:ok, account, token}
  end
end
