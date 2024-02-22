Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1293E498
	for <iwd@lists.linux.dev>; Thu, 22 Feb 2024 14:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708612672; cv=none; b=pVJ2mVW+dBnGF7HkWZcqHPvADyUsM7ZBdGN6MzRzXlZGLG2o3k2E98e6sz0ua9h0GoRD2nVHbvSolWel6XQZ8OK0UYpbKNoAl9pZBBk4foG9di7jULxN7GIM4BAM8v3outXgDmrGIEFiTpEFAxL3PTT/JirL1E3eVUGD4NMaXB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708612672; c=relaxed/simple;
	bh=x38BTUZUvbb6mq1b/eERbOoQu9URBu3IBBSJUC7It0Q=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GKc1q+iszFYXOCfuXdSUC14G4eQ8L9FuQSCny1GUS54C8d/9tZpzfuN5C+8KY1WdwxkM3xrTifALoAerYUs7vj2c3o92GV0vjNuQ/9QKttx6HFr8ZwfIfWdNncqQRDjTy9Y3KAkLilU1fB1c8MtiTOZlNSzrRkTKhUBpUz1cD4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4fefc7ea.dip0.t-ipconnect.de [79.239.199.234])
	by mail.holtmann.org (Postfix) with ESMTPSA id AE621CECC3;
	Thu, 22 Feb 2024 15:37:42 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH 1/3] station: add channel number to diagnostics message
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20240221214624.601337-1-ram.subramanian@getcruise.com>
Date: Thu, 22 Feb 2024 15:37:32 +0100
Cc: iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <6736199F-95A0-4C40-87D9-889D3E49E948@holtmann.org>
References: <20240221214624.601337-1-ram.subramanian@getcruise.com>
To: Ram Subramanian <ram.subramanian@getcruise.com>
X-Mailer: Apple Mail (2.3774.400.31)

Hi Ram,

> As a small convenience to the user.
> ---
> src/station.c | 8 ++++++++
> 1 file changed, 8 insertions(+)
>=20
> diff --git a/src/station.c b/src/station.c
> index ea505ca2..39b98037 100644
> --- a/src/station.c
> +++ b/src/station.c
> @@ -4702,12 +4702,16 @@ static void station_get_diagnostic_cb(
> struct l_dbus_message *reply;
> struct l_dbus_message_builder *builder;
> struct handshake_state *hs =3D netdev_get_handshake(station->netdev);
> + uint8_t channel_num;
>=20
> if (!info) {
> reply =3D dbus_error_aborted(station->get_station_pending);
> goto done;
> }
>=20
> + channel_num =3D =
band_freq_to_channel(station->connected_bss->frequency,
> + NULL);
> +
> reply =3D =
l_dbus_message_new_method_return(station->get_station_pending);
>=20
> builder =3D l_dbus_message_builder_new(reply);
> @@ -4718,6 +4722,10 @@ static void station_get_diagnostic_cb(
> util_address_to_string(info->addr));
> dbus_append_dict_basic(builder, "Frequency", 'u',
> &station->connected_bss->frequency);
> +
> + if (channel_num !=3D 0)
> + dbus_append_dict_basic(builder, "Channel", 'y', &channel_num);
> +

we are already at channel number 233 right now. Since this is public API =
and not some internal variable that we can change, it might be better to =
just go to uint16 here to be future proof.

Regards

Marcel

