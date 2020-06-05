defmodule Monsys.Upload do
  @moduledoc """
  The Upload context.
  """

  import Ecto.Query, warn: false
  alias Monsys.Repo

  alias Monsys.Upload.Uploads

  @doc """
  Returns the list of upload.

  ## Examples

      iex> list_upload()
      [%Uploads{}, ...]

  """
  def list_upload do
    Repo.all(Uploads)
  end

  @doc """
  Gets a single uploads.

  Raises `Ecto.NoResultsError` if the Uploads does not exist.

  ## Examples

      iex> get_uploads!(123)
      %Uploads{}

      iex> get_uploads!(456)
      ** (Ecto.NoResultsError)

  """
  def get_uploads!(id), do: Repo.get!(Uploads, id)

  @doc """
  Creates a uploads.

  ## Examples

      iex> create_uploads(%{field: value})
      {:ok, %Uploads{}}

      iex> create_uploads(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_uploads(attrs \\ %{}) do
    %Uploads{}
    |> Uploads.changeset(attrs)
    |> Repo.insert()
    # %Uploads{}
    # |> Uploads.changeset(attrs)
    # |> savefile()
  end

  # save file to local
  # def savefile(attrs \\ %{}) do
  #   name = attrs["name"]
  #   file = attrs["file"]

  #   {:ok, data} = Base.decode64(file)
  #   {:ok, dir} = File.write("/tmp/"+name+".png", data, [:binary])
  # end

  @doc """
  Updates a uploads.

  ## Examples

      iex> update_uploads(uploads, %{field: new_value})
      {:ok, %Uploads{}}

      iex> update_uploads(uploads, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_uploads(%Uploads{} = uploads, attrs) do
    uploads
    |> Uploads.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Uploads.

  ## Examples

      iex> delete_uploads(uploads)
      {:ok, %Uploads{}}

      iex> delete_uploads(uploads)
      {:error, %Ecto.Changeset{}}

  """
  def delete_uploads(%Uploads{} = uploads) do
    Repo.delete(uploads)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking uploads changes.

  ## Examples

      iex> change_uploads(uploads)
      %Ecto.Changeset{source: %Uploads{}}

  """
  def change_uploads(%Uploads{} = uploads) do
    Uploads.changeset(uploads, %{})
  end
end
