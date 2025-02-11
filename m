Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1221226562F
	for <iwd@lists.linux.dev>; Tue, 11 Feb 2025 20:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739305966; cv=none; b=AjVN3BlJwrvnqRZbPl2G0ep8jBIO/sNYlhurX4efoBmUmES2n5m5ge+UXdwsmClevCXxr6W+aT+/tvcJ+Hw9lAKtelTI3AXzdBW8lUM9jWK3asZybzWXlyW07fd+vBfTKrYWybdusibPEVx3KT52GYSoSXO+Yb5Z51qCE1DxOgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739305966; c=relaxed/simple;
	bh=rog+beRkbCdEC3Zntyx9KGFoNeOdQGBKc5tYzIwP4CE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ao7fQbnb/+XeNVZ7snnU07xbmFVlGgZp0EsIu2UfIwmADQ+obyR7J1P/bEeFt4pJTPuoXYkYG6h271zi9/J8wtLEUWJivvSUVH8kGwdGvuJcTqiGnS9hb22AD1zAgwqVlHSZkN/KA06+rE/wAjlAF27YiSXJeuhxFmx9ZM1ECB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUaac5id; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUaac5id"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fbf5c2f72dso208886a91.1
        for <iwd@lists.linux.dev>; Tue, 11 Feb 2025 12:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739305964; x=1739910764; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9XtbTu2DAPf9ACFDOq++PE5iP9nHlFZk2pWZJtDdoI=;
        b=WUaac5idZheaMF/osiFQghi8cKCoZxmw3+H3S++GsitUSdk6ACXagGDlSsglrx4IE6
         Ph4BAqa/RhfKD/RP35Kf+hT90Dr7nmea6HZKuMacZLegSExwVldZhJa8fAZfA27hkhp3
         Ymd3ziYXeqZC7vhpl4wxOxD03FAbLMiimOHnyeXWC1+5Z7sohyr96lC5+3MuLoAqzLch
         a3LgVwIJS8uYU9yUKxH2MUDUZQOrQTu+JveNQMC4J0biduyZoDj4d/GykTx7tt5VhrL1
         cLrjg15mF0bP5u4MRsUFI7GI4ZuOK9vGUmN3xn/C/WaUXdoyRKPAqbzwi4c0zNs0+sE2
         bJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739305964; x=1739910764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q9XtbTu2DAPf9ACFDOq++PE5iP9nHlFZk2pWZJtDdoI=;
        b=qVut8CLieKOqVwAIf9MAbGr0wE+C1i/J2Pj3wWys+hFClGp5erS+tckqKRxLL2WK1K
         lbhdk5XuZCgReMDwsCBbtk99xH2LLZH+yy3EkeX2UrXOmMmCYLfTPPoxoubaXMvbK5Dy
         floVNXFxWwYrF2N201/J02DCWR4xpNsxLntWL1CE/UfyNMo2QjdzH+TnuWYWudziaItj
         vyci7bddlmUNDvR6rI7R6nBpO8zwW9JNKfjN8oXe/am1gNvBGRAKv5/9dkMe7Js8Va3t
         ZBvlVdbHrDzP888sy8Wriwqj/lnywqEGeN/7v2pTV9dCcdA4VtnhlpWemf5koVKx+190
         O50g==
X-Gm-Message-State: AOJu0YwX8qZEUj+dbu59s4I6LtIZ+Zq0MLezGaEqN1k6lD9yxagFCsbn
	deOnrbv9OPwv+LkGaDLHRKLkESurjKk2Y9pT6w41nMOyf30ZHs2Z2J+obD2jbTqcrw3uKmR/8v0
	cC9qZccPpPHF4qOJeoBhl5lSkWlKuidyL
X-Gm-Gg: ASbGncugXAY/XFdBu9iBHvLLW8rzODp1aiZ0/kYduhbKVMZ5L+qykoeizndBWPd4tI1
	2eT/nc8hy9k2Ajcdet8Zw5fI4lD0S/0loi+5r2DgQP5SzNbq70P6Edg44MbjtMUiMVIhTaDgT85
	M=
X-Google-Smtp-Source: AGHT+IF2bU5DyrHF9T2GZ2plIcegxlRUaqVuQ6t/AmE16/vx4f8EVR8wCq7pcbsdUQTY/4/kjrhOQdwZESBtaPo96aU=
X-Received: by 2002:a17:90b:51cd:b0:2ee:e18b:c1fa with SMTP id
 98e67ed59e1d1-2fbf5c57f6amr709532a91.28.1739305964109; Tue, 11 Feb 2025
 12:32:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250211195855.85360-1-prestwoj@gmail.com>
In-Reply-To: <20250211195855.85360-1-prestwoj@gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Tue, 11 Feb 2025 14:32:32 -0600
X-Gm-Features: AWEUYZkJ1kGzy3lP5SDf_nTAKXPZoBJanPWdzcCKmSMBw3aVcuJm_tMVd5CLufc
Message-ID: <CAG17S_NoY9QYnDEjTBCxfCzOdPY-qibxGdYGPMvhU3DQXBHyvQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] wiphy: add driver quirk to disable SAE
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 1:59=E2=80=AFPM James Prestwood <prestwoj@gmail.com=
> wrote:
>
> SAE/WPA3 is completely broken on brcmfmac, at least without a custom
> kernel patch which isn't included in many OS distributions. In order
> to help with this add a driver quirk so devices with brcmfmac can
> utilize WPA2 instead of WPA3 and at least connect to networks at
> this capacity until the fix is more widely distributed.
> ---
>  src/wiphy.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/src/wiphy.c b/src/wiphy.c
> index c7df648a..46f7a6d9 100644
> --- a/src/wiphy.c
> +++ b/src/wiphy.c
> @@ -74,6 +74,7 @@ enum driver_flag {
>         POWER_SAVE_DISABLE =3D 0x4,
>         OWE_DISABLE =3D 0x8,
>         MULTICAST_RX_DISABLE =3D 0x10,
> +       SAE_DISABLE =3D 0x20,
>  };
>
>  struct driver_flag_name {
> @@ -106,7 +107,8 @@ static const struct driver_flag_name driver_flag_name=
s[] =3D {
>         { "ForcePae",           FORCE_PAE },
>         { "PowerSaveDisable",   POWER_SAVE_DISABLE },
>         { "OweDisable",         OWE_DISABLE },
> -       { "MulticastRxDisable", MULTICAST_RX_DISABLE }
> +       { "MulticastRxDisable", MULTICAST_RX_DISABLE },
> +       { "SaeDisable",         SAE_DISABLE },
>  };
>
>  struct wiphy {
> @@ -202,6 +204,9 @@ uint16_t wiphy_get_supported_ciphers(struct wiphy *wi=
phy, uint16_t mask)
>
>  static bool wiphy_can_connect_sae(struct wiphy *wiphy)
>  {
> +       if (wiphy->driver_flags & SAE_DISABLE)
> +               return false;
> +
>         /*
>          * WPA3 Specification version 3, Section 2.2:
>          * A STA shall not enable WEP and TKIP
> @@ -1368,6 +1373,9 @@ static void wiphy_print_basic_info(struct wiphy *wi=
phy)
>                 if (wiphy->driver_flags & MULTICAST_RX_DISABLE)
>                         flags =3D l_strv_append(flags, "MulticastRxDisabl=
e");
>
> +               if (wiphy->driver_flags & SAE_DISABLE)
> +                       flags =3D l_strv_append(flags, "SaeDisable");
> +
>                 joined =3D l_strjoinv(flags, ' ');
>
>                 l_info("\tDriver Flags: %s", joined);
> --
> 2.34.1
>
>
James,

What should I do with this patch? Should I apply it? (I do not think I
should). I am trying to get the kernel patch in the 6.6 kernel. They,
RPiOS, just pushed a new kernel 6.6.74 and the one line patch is not
yet in there.

I guess I do not really understand what you are proposing. The default
RPI kernel, with the patched version of IWD 3.3 (with the'[RFC]
netdev: avoid PMKSA for fullmac drivers') patch will connect properly
with wpa2 SSIDs when used with the un-patched kernel. The patched
kernel will also connect to WPA2 SSIDs with the bonus of connecting to
WPA3 as well.

Curious,

Keith
