Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC9427F4CA
	for <iwd@lists.linux.dev>; Wed, 23 Apr 2025 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420031; cv=none; b=JHyvIAkJ1Lcl7Pwp3Kw6AXT5AhJLXSdO3WS6g0csLTN/yCyRDDIC8qdDGEoyCHfVJgiC1QLDy2oQClhYCNzp6BShBwH8Ie7xbqpR49Z5W/o9DAq3B07eBYhPqPmjRrL56v0SkYyMIz0EgtQyw9EqVjIiJWsz9ckaIvQzwR0+UEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420031; c=relaxed/simple;
	bh=XcCu0xSpyMuHnLwWR8kEnc+2aQbNp7TyfwRy1ujuKKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YrzwfRjsyvRQ6/eqqEG6QvFSzMfBRZY2JZhYtYr8L1+Fr5GIgJrP23jlPDQTCf7K1Dul7Th/AmiM2Q3x5W6msfMaB2sTMtoSrgoywc0mv64Tuu1vDVLZezQfo1/XS/XVE9ty0167RRU87MXdTL0OesAMJS+Y4EFZ4qfQh1WhTds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEnk7mJK; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEnk7mJK"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-72ec926e828so1873043a34.0
        for <iwd@lists.linux.dev>; Wed, 23 Apr 2025 07:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745420028; x=1746024828; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fBfHHlEKLoCPd/ofUrVcXrkvY4dXmpXlQ7dA5iJ3QYA=;
        b=JEnk7mJKsKQb9MkUZ3o0azDBqINTGkQqYLdcKp5FEa0DyviyIjaUhgXFfWG/hkXRgN
         gpkaStgKAlGS65ZynzNGJyVl5ayUbfpj5nXiO6i8jlNsUYbJk1+6LVZsiyR0wr+LCzNX
         TxdhYXsZqsetR25oIgj6lMuHFXK5ERVZFS2MRTU87pKlvPu66vNIIcvdk79mxHcRvHhD
         /BfAGhQGekSuaVAbB+WFQJSbDbsd6f312Q2bz+rQnH++TpFyhnSxq8KZjXETeF1JmkSj
         m9s/6uJyCTP3mgkneRvsYQ7fKLUZy4fq8gkIPcBxQ4k+KheghLwmQB1HuvRdSfzNhtek
         D0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745420028; x=1746024828;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fBfHHlEKLoCPd/ofUrVcXrkvY4dXmpXlQ7dA5iJ3QYA=;
        b=nWef6X55rAa/EjHnjaPMDi1i3m9ix1n4dFa6qJF5ylnot2kIDx7LEto/UMrtF6Yxso
         KFw43Sfgy6cwdqEo+S+5yOSE+HiK9F94PxShZn3bXC3wXBFpjgri7jjMhzk/J90N+y4H
         D5ovCipXOmkqUQpFnPveCKe1/nGaL9GAY8v/F/Ym8zZynjeqtil3N0vJ3bG0UQVw17rM
         RHbLZwBCOOiWCQjzx2yWepBkgJgZJHTp18MbyZ6EsSgX01+diD9BzF2wuj1+IXsly5Tn
         kBBmdlD4pZoe78MNxSstc3pfCF7+2P8Am9DSZWNbA9KEwsHBF1KcSQ3PI7YLYBI0S1/J
         We+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOJR/roJxXHtdOb8Yq/cX/OKpJd6Y7xx643q/MRaS4CcGh4zIGi6JXLfNnaIOaH+PldyM=@lists.linux.dev
X-Gm-Message-State: AOJu0YyAT4UV/4gXha5m99YsEQcPf+heD7ZBNcjIP1OuB+6M6ch3Koaj
	KyDBBRaxRX0sP+8hylJWygbbPAavTSUIr/8+VCE+iXFQbo0vlTNG6OAzOA==
X-Gm-Gg: ASbGncsIf1APoi6WE7SVddrrxfGrGyM4ZW0fBTrdqoS6O9e5oZ67iUoF3Nx9kG0YXcD
	UineadAQEqLqtDgJrvuZbsbnocXfw8YvxvOGZtIkhnv6NjgCLohjsi+2FmuIb21PgYsxYwUNL0N
	dbBjqTtlvxzF1RJuNKU10uaTEpusqgjjamxI3Ay+MJcsCn8WGsswglUACDnxVnE355mdNaJ5i0G
	P0z7QOS+pdXtMHcIhFnk1M6gHvlMEm4IgnXyjnnOCk+kBsboGEvHekdG6jwnsNZZiMdQA1qr+Q4
	TWSx4qX3OjkX72PFYsXdzrVOgkv/p9A4AZSgf/McoCzWG/JXPB/TWzc1jbS6kkrqaD3NmMI4yCW
	vsWOQOw==
X-Google-Smtp-Source: AGHT+IHvdgTAomoYi6Hg8nWebZyyzBYjVP28cdsu1LLnxiGlsDTgO+BC/7srgci7dJZirMt5yWaFug==
X-Received: by 2002:a05:6830:3902:b0:72b:9d5e:941c with SMTP id 46e09a7af769-7300622d0a7mr11967553a34.13.1745420028649;
        Wed, 23 Apr 2025 07:53:48 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7300478edf7sm2534739a34.10.2025.04.23.07.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 07:53:48 -0700 (PDT)
Message-ID: <cf654842-20d3-4d1d-a602-2f75ea3f204b@gmail.com>
Date: Wed, 23 Apr 2025 09:53:47 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] client: add SignalStrength/Frequency properties
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20250423135458.11337-1-prestwoj@gmail.com>
 <20250423135458.11337-3-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250423135458.11337-3-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 4/23/25 8:54 AM, James Prestwood wrote:
> ---
>   client/bss.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/client/bss.c b/client/bss.c
> index def4de7f..19355f0b 100644
> --- a/client/bss.c
> +++ b/client/bss.c
> @@ -32,6 +32,8 @@
>   
>   struct bss {
>   	char *address;
> +	int16_t signal;
signal_strength? or rssi?
> +	uint32_t frequency;
>   };
>   
>   static const char *get_address(const void *data)
> @@ -57,8 +59,52 @@ static void update_address(void *data, struct l_dbus_message_iter *variant)
>   	bss->address = l_strdup(value);
>   }
>   
> +static const char *get_signal(const void *data)

signal_strength?

> +{
> +	const struct bss *bss = data;
> +	static char signal_str[7];
> +
> +	sprintf(signal_str, "%d", bss->signal);
> +
> +	return signal_str;
> +}
> +
> +static void update_signal(void *data, struct l_dbus_message_iter *variant)
> +{
> +	struct bss *bss = data;
> +	int16_t value;
> +
> +	if (!l_dbus_message_iter_get_variant(variant, "n", &value))
> +		return;
> +
> +	bss->signal = value;

ditto

> +}
> +
> +static const char *get_frequency(const void *data)
> +{
> +	const struct bss *bss = data;
> +	static char freq_str[5];

There is hardware that supports frequencies in the 60G range.  Might want to 
future proof this somewhat.

> +
> +	sprintf(freq_str, "%u", bss->frequency);
> +
> +	return freq_str;
> +}
> +
> +static void update_frequency(void *data, struct l_dbus_message_iter *variant)
> +{
> +	struct bss *bss = data;
> +	uint32_t value;
> +
> +	if (!l_dbus_message_iter_get_variant(variant, "u", &value))
> +		return;
> +
> +	bss->frequency = value;
> +}
> +
>   static const struct proxy_interface_property bss_properties[] = {
> -	{ "Address",       "s", update_address, get_address },
> +	{ "Address",        "s", update_address, get_address },
> +	{ "SignalStrength", "n", update_signal, get_signal },
> +	{ "Frequency",      "u", update_frequency, get_frequency },
>   	{ }
>   };
>   

Regards,
-Denis
