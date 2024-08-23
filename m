Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40397189B89
	for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 21:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724447033; cv=none; b=DbL7AxljAQ9gl8kWM5M7QIZWmMwhZs3yaSUUT7TrztNHuYfyvMEx/MrLZeUG2BBfMLkSrqiugmqLQwguTtdKtZX7cTo2ojRYkKB5BG3GswzLOzJfvFmhQXKSp13/7sWj/Wc9uJAhEoa3lzd4VIUBfvpJiXSARIxG9UVNxTwzKhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724447033; c=relaxed/simple;
	bh=aKGI9w/BYE3OLoFosCGM2SOGycMc1QKApraDCnUdwf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q+JXnhiU1L66aSRTmMPhMCBHyLBa06FMlgZlnY/GKEb4VsuXt3lMQTFIW7V8DgeowRC1G9Q1mfo8DKMV4aFA4czewG2we/DOIyWJSLv3aaENYjCgMaZRKb/msJAqDKj81xBap4iRF3/iNFMCs8AFnNTfFnrCFP2afW1XY4SQrsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=density.io; spf=pass smtp.mailfrom=density.io; dkim=pass (1024-bit key) header.d=density.io header.i=@density.io header.b=s/H7RK5u; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=density.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=density.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=density.io header.i=@density.io header.b="s/H7RK5u"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a86abbd68ffso149515066b.0
        for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 14:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=density.io; s=google; t=1724447029; x=1725051829; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ip1T9ZzHjFnn9G4x9f1+YHOf6hwHrVOOWEK4u+mukGE=;
        b=s/H7RK5u6gCiWRGE7KZfwJkMav11r67tfkodKsJ0+YndyvvFpaY96h8YVrwaNXdQjg
         +EQsVk2RqI/7hgzvx5mRr0vMNDqd73YLUnD5d9aUcoRuYET2BhvmaoDp+sjiYRA8x6Dm
         DMqHqvp1G84ouLNrhTHaL2uj6Dmoh0Laz3pdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724447029; x=1725051829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ip1T9ZzHjFnn9G4x9f1+YHOf6hwHrVOOWEK4u+mukGE=;
        b=vyu1DwolcE7jtBIgySy8i/h2PmFuVeusQRPhBzGeMm3xaSfChA2lIGJvdnKoHdsmln
         sUOlW8xTjcs34SVZ6BWUmytK/ID0/r1BB+mjzCjZFYnYq6D9yJNm0V82epLPgCYBqRNn
         VWV+uKx5PxU+BOnTf0LeHQ5cOlcTlVvd5PFzO6sE3tAuOqbWwPGLw5dz/NmrWYIeo5S2
         G3fO4q5H77VJmjC2V2aOnFrLkUwkMxv+2BVS6oRJhV43/nXyl9keai4TYGNd7oSm3Efd
         yqh5HEb/S8TCSpVEoMcFshapXCQ1Hc121VVB24kHn8g9u/XM5h/aeaG2P9WGgbmQvDhS
         2ZxA==
X-Gm-Message-State: AOJu0Yxmun8vyE7Ad4yHiPXStMJtQfqA0hRFhh7JyS5qkt56x8uoAAAv
	T8ICs6OvtyzjZSyGt8+nnN2WEkraTeZ4arwMffQa7AIQbnU2OjyxHTIKd+vqZGIJhesEIFj0Fsz
	8ASvWfgnGcO/b4vOs33bxwylTdDuugfSRl+N7d7+w6xz2zUAenJU=
X-Google-Smtp-Source: AGHT+IE54z9TNCg+YGZMZcYK+MPIjMGg16wrDVdyZX9/BOWiDOgM/+YIQb3v6fEIP3lw3Js/v/kBJ4COBl2ui8RfatI=
X-Received: by 2002:a17:907:7f1f:b0:a7d:89ac:9539 with SMTP id
 a640c23a62f3a-a868a5af23cmr787600366b.7.1724447028724; Fri, 23 Aug 2024
 14:03:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240823180006.317353-1-prestwoj@gmail.com> <20240823180006.317353-2-prestwoj@gmail.com>
In-Reply-To: <20240823180006.317353-2-prestwoj@gmail.com>
From: Ryan Smith <ryan.smith@density.io>
Date: Fri, 23 Aug 2024 15:03:37 -0600
Message-ID: <CAM7Wg-V7rGu1P666PFpVb2sHKbe+34r=GBZgRT6VePkjzmFEVA@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] netdev: define netdev settings in netdev.h
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
Just glancing through this...

On Fri, Aug 23, 2024 at 12:00=E2=80=AFPM James Prestwood <prestwoj@gmail.co=
m> wrote:
>
> Following knownnetworks, this moves the settings into a header file
> which is easier to maintain/read.
> ---
>  src/netdev.c | 8 ++++----
>  src/netdev.h | 5 +++++
>  2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/src/netdev.c b/src/netdev.c
> index 494e46a5..4d6aae6b 100644
> --- a/src/netdev.c
> +++ b/src/netdev.c
> @@ -6264,16 +6264,16 @@ static int netdev_init(void)
>                 goto fail_netlink;
>         }
>
> -       if (!l_settings_get_int(settings, "General", "RoamThreshold",
> +       if (!l_settings_get_int(settings, NETDEV_ROAM_THRESHOLD,
>                                         &LOW_SIGNAL_THRESHOLD))
>                 LOW_SIGNAL_THRESHOLD =3D -70;
>
> -       if (!l_settings_get_int(settings, "General", "RoamThreshold5G",
> +       if (!l_settings_get_int(settings, NETDEV_ROAM_TRHESHOLD_5G,
>                                         &LOW_SIGNAL_THRESHOLD_5GHZ))
>                 LOW_SIGNAL_THRESHOLD_5GHZ =3D -76;
>
> -       rand_addr_str =3D l_settings_get_value(settings, "General",
> -                                               "AddressRandomization");
> +       rand_addr_str =3D l_settings_get_value(settings,
> +                                               NETDEV_ADDRESS_RANDOMIZAT=
ION);
>         if (rand_addr_str && !strcmp(rand_addr_str, "network"))
>                 mac_per_ssid =3D true;
>
> diff --git a/src/netdev.h b/src/netdev.h
> index db0440d0..d718fa6a 100644
> --- a/src/netdev.h
> +++ b/src/netdev.h
> @@ -29,6 +29,11 @@ struct eapol_sm;
>  struct mmpdu_header;
>  struct diagnostic_station_info;
>
> +#define GENERAL "General"
> +#define NETDEV_ADDRESS_RANDOMIZATION GENERAL, "AddressRandomization"
> +#define NETDEV_ROAM_THRESHOLD GENERAL, "RoamTreshold"

Spelling typo - RoamThreshold

> +#define NETDEV_ROAM_TRHESHOLD_5G GENERAL, "RoamThreshold5G"

Spelling typo - NETDEV_ROAM_THRESHOLD_5G

> +
>  enum netdev_result {
>         NETDEV_RESULT_OK,
>         NETDEV_RESULT_AUTHENTICATION_FAILED,
> --
> 2.34.1
>
>
