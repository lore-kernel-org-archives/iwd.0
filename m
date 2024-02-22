Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4BE3A8E4
	for <iwd@lists.linux.dev>; Thu, 22 Feb 2024 14:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708612034; cv=none; b=HdcXl1cicDN4Cc85kuhsksDT4ch/RniW4vyBxXEK8ZChcJRnfpDC+kNv2FhD9rTMdokRhy8pZZq4cyuSwYO0P5n36N1BV6LpZt0tDZ4311N2kjGQ3UMHZU0G0DRZlQRk/57B6pKR2jgFM2DUZEcEv8vKunDUt8iyp9HN8Z7fMho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708612034; c=relaxed/simple;
	bh=VZc2uAzjfb+zLGX8fMUxiH/gnhQ53h2guhgpNj+6cJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GARBvLRbaOzE3476cqe4iL1I6zp+Ad8I5Gzcfz/YrKL0+9ZrscomdgIaLmjAWZVG1vfpqAikcOe3C4NVOjpoEJmAqWguadMpyhtdvCkI02PllGLoTnWeYt6HSZ2mY7URwOLmDo2KKQjZCENckko7nmA4NUUHp/ZdP0Mzha386XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jh1HlTks; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jh1HlTks"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-608a1deb6d4so4349397b3.0
        for <iwd@lists.linux.dev>; Thu, 22 Feb 2024 06:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708612032; x=1709216832; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mvHqaPfGhz0Ns5tKyDCszshXvPrQ+Yxq5c3vZUclAMg=;
        b=jh1HlTksrdkTOctzsXmOsJvx34Cgrhrft2rDVj5l2L9ItAkUpKmEQV4rjcaqD8OyLn
         SL59xV5glQyP+YM/5FSwinrJsISA1VchNZLk66EBfu1EBBds6RXnXNeKjFcQ8YNYjdJz
         CceqKTfvf7+NkD4pjyWvkipKGbQt3pK8kcChihR4xe+ox7soKFJTBlDG8NlokuDrypXi
         dUTK5TkJgAfwV8/WqdvxbzFpyXICm+lhxjzytyCLFZu71rMrP/X+xNV+42wnhAZQ7o1g
         zejeEE7cje+pfcbLrw+wG4huviTBASemRpDIOAvWv8q3v8W48GiRDD+bWLEmSh0OeKqX
         Hi7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708612032; x=1709216832;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mvHqaPfGhz0Ns5tKyDCszshXvPrQ+Yxq5c3vZUclAMg=;
        b=HgJdNhbSEDmhunPqUb1YLfSjSaK4tn6YgoW0JZwNvYgfZBKKB/5drUIwSWzcmZoJGs
         RFin6ryxjkChr5TiYw31MZdw1r+mUqw9CvsEMfOnulNY9YArizT6rDlwLc1tii2qXagO
         C06Hz8ECPOuO7x+x3VC1noHJqGjnL9+jV05CdE7QeomRaLnxDd/IE7BTLUgYFNgCiGGW
         G8i0yIgb+/zIlgLaPofiSC5oEFhB+RUg8ixXGPt9IqRkW7vDDUCGKIiY3VBa9uUd4aYx
         8zr28vY2IxU03RCxM/svit6LlkHch7oM1lYclb16unCWkwf3A1nkfJu9nvck5Wdhv88G
         f6fA==
X-Forwarded-Encrypted: i=1; AJvYcCVYDFKdUbTIZOLQxKIfVLA34HiYtCPpcMEXZWZ3RrohCPLGfmI1VmjJRtOJsj/ysLVboC6bSKns9MkuMS2DlRlkq7qC
X-Gm-Message-State: AOJu0Yxv3AZy3VFhgXHf85p+Jv5DOAKejJZic03VdKWDiTxP4DxxBcIz
	ULyHS1W4696D82yn7rtT3q1Of5gAFMs92ATHXRhAHo9ChQm9q3TxMLkhOp69
X-Google-Smtp-Source: AGHT+IGrizrGaWch7CHGCQHqedLi8C/qSg4KeDux2Kg5SNCh37csL5A7aEuYR014pw7b8hRo7Hn4Rg==
X-Received: by 2002:a81:a743:0:b0:607:9dda:676c with SMTP id e64-20020a81a743000000b006079dda676cmr21315124ywh.18.1708612032198;
        Thu, 22 Feb 2024 06:27:12 -0800 (PST)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id w4-20020ac84d04000000b0042de6b5c92csm5440540qtv.35.2024.02.22.06.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 06:27:11 -0800 (PST)
Message-ID: <c769d927-0e4f-49a1-bf46-325b459c7537@gmail.com>
Date: Thu, 22 Feb 2024 06:27:09 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] station: add channel number to diagnostics message
Content-Language: en-US
To: Ram Subramanian <ram.subramanian@getcruise.com>, iwd@lists.linux.dev
References: <20240221214624.601337-1-ram.subramanian@getcruise.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20240221214624.601337-1-ram.subramanian@getcruise.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ram,

On 2/21/24 1:46 PM, Ram Subramanian wrote:
> As a small convenience to the user.
> ---
>   src/station.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/src/station.c b/src/station.c
> index ea505ca2..39b98037 100644
> --- a/src/station.c
> +++ b/src/station.c
> @@ -4702,12 +4702,16 @@ static void station_get_diagnostic_cb(
>   	struct l_dbus_message *reply;
>   	struct l_dbus_message_builder *builder;
>   	struct handshake_state *hs = netdev_get_handshake(station->netdev);
> +	uint8_t channel_num;
>   
>   	if (!info) {
>   		reply = dbus_error_aborted(station->get_station_pending);
>   		goto done;
>   	}
>   
> +	channel_num = band_freq_to_channel(station->connected_bss->frequency,
> +						NULL);
> +
>   	reply = l_dbus_message_new_method_return(station->get_station_pending);
>   
>   	builder = l_dbus_message_builder_new(reply);
> @@ -4718,6 +4722,10 @@ static void station_get_diagnostic_cb(
>   					util_address_to_string(info->addr));
>   	dbus_append_dict_basic(builder, "Frequency", 'u',
>   				&station->connected_bss->frequency);
> +
> +	if (channel_num != 0)
> +		dbus_append_dict_basic(builder, "Channel", 'y', &channel_num);
> +
>   	dbus_append_dict_basic(builder, "Security", 's',
>   				diagnostic_akm_suite_to_security(hs->akm_suite,
>   								hs->wpa_ie));

These all LGTM

Thanks,

James

