Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA93280A5A
	for <iwd@lists.linux.dev>; Wed, 23 Apr 2025 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419871; cv=none; b=ZdqUcKPsFUSuCtL4wFnIxiuzdzSHillrZ/V/nM7IlEJAcG049Hg88okYonowK8IWFk38e4gFH2hpYZS+sJ3g4q5Ss/1CiUDNAnrFWtBcNfMkHNIZDJWlWzZK96k3pBwlc7D6/2+EZRPJMx1yxlVdMQhACQAlAhWTB+UVhawO8N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419871; c=relaxed/simple;
	bh=M2T8EHTNKqcyft4iwatOZcNuztmhXgbehXYq9AmkU/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=U6YDpX36VuIpXJC6IgEwpBObRVH1komo3djJFcb9e7PfVvduigg6eKPu61QtnBctpePiaVvcvn4Sc3+36tXrspW2V9Z7uz8pvYKO3iOSrnJoFJhMBZ+vLgz2PGPvn4qz5ocpGgPFDrqVIFrJtUooac70C741jCqo/0yP5faJhzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NitGXIMd; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NitGXIMd"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3fbaa18b810so1774071b6e.2
        for <iwd@lists.linux.dev>; Wed, 23 Apr 2025 07:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745419869; x=1746024669; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NTFUfz5M8SEMdp0Ok0eXJ342Q+nIfw8it3TIEDOFzzE=;
        b=NitGXIMd65/eOpMqJHk7TFyx3gHt5/1wBDN3+IWvCrAOwVstNKnNwZSHH8X9uJGd9i
         Gqz9kfIhJNDpeS54UhMfiv6uo2b5IY7CLUWXGW6E2/EDRHQIJdVdPBv9bYvFip0OsG/q
         UWOOCZvbwO6G+dSgEMF/22pvo5W2A3c9iNuOnIx0GIUz6r5Vt2moazTWeZ8iwxs8o6jk
         wC+69XzjK2CB8o/yNBwTqc5hSOB+p8GmmcDYpUScapAu4Gb7FfOl9r4BHyn3LzZFOrFu
         MSaqlJBS6lovqad0VGj0bnQL8HXfo9gXJNI4jiUp3/3e0K0SfuzQ3DfHJyaLbBVUtprr
         hj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745419869; x=1746024669;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NTFUfz5M8SEMdp0Ok0eXJ342Q+nIfw8it3TIEDOFzzE=;
        b=usLcbYYcugeI8zJaIcUNhF/oO6wpMnJn4dc2S2Qepk0EguGmwBm1LFQd4upTVTl/JG
         VG6y4dMj00eeulkueTFUg7Ctz1SB77qs0Q7w6ev87ymYSd4qiydadP5D5qoMo7V11uM9
         gC0Cdt/J44gy89fLR5KnZCS/ThZX4Ppp+uirO0HOWSHasaRtkLJ0FtwTJrJnKFIXjEJY
         f2YLduXscPi09jczm+g+KnJMcClxOFX4zpb1SPdR8u9PZNnF+jN84n/H+ytWGyrScErj
         o/EB7C3z2W1qbdM02du1RTfqcQCP5xK37DxlYyIhtdBF/k/HsZcALCq+gU4+bS4We3m1
         Eygg==
X-Forwarded-Encrypted: i=1; AJvYcCX61UwDQ3uu5cLELI5vMELEz1eZH7Sr6/Tp5nXVKmn2sIPyiguT0WlSBEeSbqSqUcDHjNE=@lists.linux.dev
X-Gm-Message-State: AOJu0YzmDiZKjGCQtIsB6342Uvci7yT/dewMrIsRulDAsLcVYCeZMp+B
	CTk4RHPyGPW+sbDbcsByxDtSe6RBY55Tamg8lPyFPSTdr2sfhz7LnN+twQ==
X-Gm-Gg: ASbGncvpYu31oEf0Y7n7HTU1qj6u1LzXEGzu6I/jAiOcPy4YZ4S6NJGd/OhRTJPb1Os
	iuB0SQ8kpCo6M2jAbP+FBo/x+b9Kmixbk67lYC0HrIXBl98Jfx40Tw0Zam+HrOe5vIDqwxzeXlh
	E9fbuUw/YxVTUHGmi1NgE1FPMmP4URiytHvzg6dJn390XL0ewMlKKa7oI4oJzut6LVNSxKEyuQx
	nQRrzW21UeFQF9dJb2S1dbPxuZeLdwezCSW6EY+smt8LSdG3bI5Y22d23iudWuhbFMOXpcQI6nl
	Mr64RHKX0IzWwihLQwAmF3Hg7A8Lv0xe1bnx5QKJxpG06HUHqS3mdjx0lF8LPAJrqfLcfUBOp2s
	Nr9c2cw==
X-Google-Smtp-Source: AGHT+IEaxBVBqGrmqxVNlOAbNbygwE0OpFTruC0qkhkuFPBBgnQ6kT+Z2O119sEZUwQdvd6fKnsejQ==
X-Received: by 2002:a05:6808:3847:b0:400:b701:33ce with SMTP id 5614622812f47-401c095cc62mr13350940b6e.13.1745419868941;
        Wed, 23 Apr 2025 07:51:08 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-401beed8a52sm2663234b6e.16.2025.04.23.07.51.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 07:51:08 -0700 (PDT)
Message-ID: <f95cd199-5aea-4a7c-8f1a-35770bb24c5a@gmail.com>
Date: Wed, 23 Apr 2025 09:51:07 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] network: Add SignalStrength/Frequency properties to
 BSS interface
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20250423135458.11337-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250423135458.11337-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 4/23/25 8:54 AM, James Prestwood wrote:
> This patch adds SignalStrength and Frequencies properties to the
> BSS interface, which will provide more information for individual
> BSS's.
> ---
>   src/network.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/src/network.c b/src/network.c
> index 4602a110..2443d4c5 100644
> --- a/src/network.c
> +++ b/src/network.c
> @@ -2194,10 +2194,39 @@ static bool network_bss_property_get_address(struct l_dbus *dbus,
>   	return true;
>   }
>   
> +static bool network_bss_property_get_signal(struct l_dbus *dbus,

nit: Can we use ..._get_signal_strength here?

> +					struct l_dbus_message *message,
> +					struct l_dbus_message_builder *builder,
> +					void *user_data)
> +{
> +	struct scan_bss *bss = user_data;
> +	int16_t signal = bss->signal_strength / 100;
> +
> +	l_dbus_message_builder_append_basic(builder, 'n', &signal);
> +
> +	return true;
> +}
> +
> +static bool network_bss_property_get_freq(struct l_dbus *dbus,

nit: ..._get_frequency

> +					struct l_dbus_message *message,
> +					struct l_dbus_message_builder *builder,
> +					void *user_data)
> +{
> +	struct scan_bss *bss = user_data;
> +
> +	l_dbus_message_builder_append_basic(builder, 'u', &bss->frequency);
> +
> +	return true;
> +}
> +
>   static void setup_bss_interface(struct l_dbus_interface *interface)
>   {
>   	l_dbus_interface_property(interface, "Address", 0, "s",
>   					network_bss_property_get_address, NULL);
> +	l_dbus_interface_property(interface, "SignalStrength", 0, "n",
> +					network_bss_property_get_signal, NULL);
> +	l_dbus_interface_property(interface, "Frequency", 0, "u",
> +					network_bss_property_get_freq, NULL);
>   }
>   
>   static int network_init(void)

Regards,
-Denis
