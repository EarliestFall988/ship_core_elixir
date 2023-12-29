defmodule ShipCore.Accounts do
  import Ecto.Query, warn: false
  alias ShipCore.Repo

  alias ShipCore.Accounts.Account

  @doc """


  Returns the list of accounts.

  ## Examples

      iex> ShipCore.Accounts.list_accounts()
      [%ShipCore.Accounts.Account{...}, ...]
  """

  def list_accounts do
    Repo.all(Account)
  end

  def get_user(id), do: Repo.get!(User, id)

  @doc """

  Returns the account with the given `id`.

  ## Examples

      iex> ShipCore.Accounts.get_account("123")
      %ShipCore.Accounts.Account{...}
  """

  def get_account!(id), do: Repo.get!(Account, id)

  @doc """

  Gets a single account.any()


  Returns 'nil' if the account does not exist


  ## Examples


      iex> ShipCore.Accounts.get_account_by_email("test@email.com")
      %ShipCore.Accounts.Account{...}

      iex> ShipCore.Accounts.get_account_by_email("not_exist@email.com")
      nil

  """

  def get_account_by_email(email) do
    Account
    |> where(email: ^email)
    |> Repo.one()
  end

  @doc """

  Creates a new account with the given `attrs`.

  Example of `attrs`:

      %{
        email: "
        password: "123456"
      }

  """

  def create_account(attrs \\ %{}) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert()
  end
end
