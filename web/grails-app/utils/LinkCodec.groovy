class LinkCodec {

  static encode = { str ->
    return str.toLowerCase().replaceAll(/[^a-z0-9]/, " ").trim().replaceAll(" ", "_")
  }

}
