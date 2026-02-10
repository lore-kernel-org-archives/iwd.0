Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918D033F390
	for <iwd@lists.linux.dev>; Tue, 10 Feb 2026 09:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770716613; cv=none; b=H+UHs8zAyoTsTXCiRYMB9L/nZP66FyIphp5cjzH0wRKVYgtdSbEbR1IXl+TU/frutV2LnROFGWv5PNdzkswp/R+Uc0vzgl+uwidsHqceMzlUX5kUagFKRhZFhxg5Pa34Oo7zqeJ5ObrJQDXAj4zfrLRvHMK2ogayrfb6gwQtsG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770716613; c=relaxed/simple;
	bh=7NdfT5AcQJgb/L1cBlwVX4CnwGZ1r/ti+JY3Equ8Vd4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=bSQz4slgRGoSYuS8BfF2gZAQj0UPkcN6i5j+Us9O+XpUuSbmfS+8nYV4tEZLV8pKSy24a/5jcC2FMJSuzXBgTG7AXqlX+JLS99E6HMFLOUH4YPmmx7U+QOn7eGzV9jFmBvYpbaK7gmAb5HgM8KR6bUR2eEkmxDX4RUoxNt0DCtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4ff9f6bd.dip0.t-ipconnect.de [79.249.246.189])
	by mail.holtmann.org (Postfix) with ESMTPSA id 9EF66CECB9;
	Tue, 10 Feb 2026 10:34:45 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: Bug with iwd-3.11 - const char being modified
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <aYpKtVUTo2QHYCT4@ca26aaf82ac7>
Date: Tue, 10 Feb 2026 10:34:35 +0100
Cc: iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <F782FF22-39B4-4414-B0C1-552E0BC3BF61@holtmann.org>
References: <aYpKtVUTo2QHYCT4@ca26aaf82ac7>
To: Rudi Heitbaum <rudi@heitbaum.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)

Hi Rudi,

> Bug report (as below) for current iwd (including 3.11) - const char =
being modified.
>=20
> When compiling iwd with recent gcc and glibc-2.43 the =
--Wdiscarded-qualifiers
> warning occurs because with ISO C23, the function strrrchr that return
> pointers into their input arrays now have definitions as macros that
> return a pointer to a const-qualified type when the input argument is
> a pointer to a const-qualified type.
>=20
> ../client/known-networks.c: In function =
'known_network_proxy_find_by_name':
> ../client/known-networks.c:296:29: warning: initialization discards =
'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>  296 |                 char *dot =3D strrchr(name, '.');
>      |                             ^~~~~~~
>=20
> The fix would be to declare dot as const char as below, but this =
surfaces
> the error that name (which is const) is being modified. See >>>> below =
-
> this being an error.
>=20
> Regards
> Rudi
>=20
> --- a/client/known-networks.c
> +++ b/client/known-networks.c
> @@ -293,13 +293,13 @@
> network_args.type =3D NULL;
>=20
> if (network_args.type) {
> - char *dot =3D strrchr(name, '.');
> + const char *dot =3D strrchr(name, '.');
>=20
> if (!dot)
> /* This shouldn't ever be the case */
> return NULL;
>=20
>>>>> *dot =3D '\0';
> }
>=20
> network_args.name =3D name;

and this highlights a real issue.

I think the current code is trying to hard. This is untested, but it =
should be fixed along these lines.

diff --git a/client/known-networks.c b/client/known-networks.c
index 8634aca23e3b..0b24a863a8ef 100644
--- a/client/known-networks.c
+++ b/client/known-networks.c
@@ -243,15 +243,24 @@ static struct proxy_interface_type =
known_network_interface_type =3D {
 static bool known_network_match(const void *a, const void *b)
 {
  const struct known_network *network =3D a;
- const struct network_args *args =3D b;
-
- if (strcmp(network->name, args->name))
- return false;
-
- if (args->type && strcmp(network->type, args->type))
- return false;
+ const char *name =3D b;
+ size_t name_len =3D strlen(name);
+
+ if (l_str_has_suffix(name, ".psk")) {
+ if (strcmp(network->type , "psk"))
+ return false;
+ name_len -=3D 4;
+ } else if (l_str_has_suffix(name, ".8021x")) {
+ if (strcmp(network->type , "8021x"))
+ return false;
+ name_len -=3D 6;
+ } else if (l_str_has_suffix(name, ".open")) {
+ if (strcmp(network->type , "open"))
+ return false;
+ name_len -=3D 5;
+ }
  - return true;
+ return !strncmp(network->name, name, name_len);
 }
   static void check_errors_method_callback(struct l_dbus_message =
*message,
@@ -276,37 +285,14 @@ static enum cmd_status cmd_list(const char =
*entity, char **args, int argc)
 static const struct proxy_interface *known_network_proxy_find_by_name(
  const char *name)
 {
- struct network_args network_args;
  struct l_queue *match;
  const struct proxy_interface *proxy;
    if (!name)
  return NULL;
  - if (l_str_has_suffix(name, ".psk"))
- network_args.type =3D "psk";
- else if (l_str_has_suffix(name, ".8021x"))
- network_args.type =3D "8021x";
- else if (l_str_has_suffix(name, ".open"))
- network_args.type =3D "open";
- else
- network_args.type =3D NULL;
-
- if (network_args.type) {
- char *dot =3D strrchr(name, '.');
-
- if (!dot)
- /* This shouldn't ever be the case */
- return NULL;
-
- *dot =3D '\0';
- }
-
- network_args.name =3D name;
-
  match =3D =
proxy_interface_find_all(known_network_interface_type.interface,
- known_network_match,
- &network_args);
+ known_network_match, name);
    if (!match) {
  display("No network with specified parameters was found\n");

And if you want to keep the network_args thing (which seems useless in =
view), then this could be a fix.

diff --git a/client/known-networks.c b/client/known-networks.c
index 8634aca23e3b..f906378602b1 100644
--- a/client/known-networks.c
+++ b/client/known-networks.c
@@ -279,35 +279,35 @@ static const struct proxy_interface =
*known_network_proxy_find_by_name(
  struct network_args network_args;
  struct l_queue *match;
  const struct proxy_interface *proxy;
+ size_t name_len;
+ char *args_name;
    if (!name)
  return NULL;
  - if (l_str_has_suffix(name, ".psk"))
+ name_len =3D strlen(name);
+
+ if (l_str_has_suffix(name, ".psk")) {
  network_args.type =3D "psk";
- else if (l_str_has_suffix(name, ".8021x"))
+ name_len -=3D 4;
+ } else if (l_str_has_suffix(name, ".8021x")) {
  network_args.type =3D "8021x";
- else if (l_str_has_suffix(name, ".open"))
+ name_len -=3D 6;
+ } else if (l_str_has_suffix(name, ".open")) {
  network_args.type =3D "open";
- else
+ name_len -=3D 5;
+ } else
  network_args.type =3D NULL;
  - if (network_args.type) {
- char *dot =3D strrchr(name, '.');
-
- if (!dot)
- /* This shouldn't ever be the case */
- return NULL;
-
- *dot =3D '\0';
- }
-
- network_args.name =3D name;
+ args_name =3D l_strndup(name, name_len);
+ network_args.name =3D args_name;
    match =3D =
proxy_interface_find_all(known_network_interface_type.interface,
  known_network_match,
  &network_args);
  + l_free(args_name);
+
  if (!match) {
  display("No network with specified parameters was found\n");
  return NULL;

Regards

Marcel



