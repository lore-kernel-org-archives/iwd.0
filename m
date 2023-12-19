Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F54882E
	for <iwd@lists.linux.dev>; Tue, 19 Dec 2023 04:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niVbIEUf"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7b7f3921044so310839f.1
        for <iwd@lists.linux.dev>; Mon, 18 Dec 2023 20:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702960302; x=1703565102; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tQaIodgMqxCGFHiYLb2txJDuuqQy9TkblTZcGn5kaug=;
        b=niVbIEUfasLyhEYnPJiKkuPMj3jCBuxHB9bIHDElNJv615JRLHXB0UHC/KR9sVpLYJ
         RoKYtSbu+pdxhxTQPTYx6HO1DeS0sz2u6vuRgBR7S+OK2+gtoQn6/P7o0hdYyajtbGdT
         n0rt0pRSe88oJOUvXGLVLSuAcOBSwVOe8lux5nTRUPR9LETapWJIg8X8dvcWWDCNLrvj
         vmC2tkHBeDZuVkUlBOqPPF9b6icxQADbkB71yupnHROdbpAaPsO8kwQ8hDEeGbXGspg+
         TCxIkUGiqjq3x2YIEDoI0KyNz/I/1ccn4rgAVsh0evWI9TqUbezlz8tYi+x2huvyX38F
         o1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702960302; x=1703565102;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tQaIodgMqxCGFHiYLb2txJDuuqQy9TkblTZcGn5kaug=;
        b=fN3+EuTqbmzf2nkGQaNIK1KlRZx9aZ6uuz/mTbBmZyYOHL+bPZvxLqIIkWvo5ZAzMl
         MHCV3AfZ7A8Rkv6G+qwQmv5dJfQpTbxgMbwQ3efaUwlQdG5kNzcVtPU+nYRMN8mY21CF
         ZH2CirMoTXu7wTz5LMWTkZzKoPfZkhkyCpaluKO3hHH5EsKlVV597dsuXF01QPM/OVuu
         YnfokP35GSvi2nsJoFnVy+n8ULIVjGXU+vCKCIk7Rcnf8sg4D4bZD/p5YFenLtBm4Uad
         hEq2fplXhk5FKYDuGl9UldDVgVuvftU4CKZAUzkmg3TFIUwYTxqPkVqLK90+fuk7Rfl8
         cFkw==
X-Gm-Message-State: AOJu0YzatE+Gf7VdCiu+tPyrdA+BfXYkI7IY+g04hMKFeNb+YUu8mGkl
	labut7p4Bv2rVLJ2caO8oXg=
X-Google-Smtp-Source: AGHT+IGP96UNFUBS0m9bUacgHBIEUkOuMQpXaEv9030ktb1Ga4wEVX+EtPmcqD22WXzJkRfulaPVAQ==
X-Received: by 2002:a92:c24f:0:b0:35f:b9ab:22df with SMTP id k15-20020a92c24f000000b0035fb9ab22dfmr1717033ilo.72.1702960302396;
        Mon, 18 Dec 2023 20:31:42 -0800 (PST)
Received: from [172.16.49.130] ([136.33.23.24])
        by smtp.googlemail.com with ESMTPSA id cv10-20020a056e023b8a00b0035d6559c5b9sm7316375ilb.64.2023.12.18.20.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 20:31:41 -0800 (PST)
Message-ID: <6ac609fa-0540-479e-8ab3-387b0cab24cb@gmail.com>
Date: Mon, 18 Dec 2023 22:31:41 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] knownnetworks: network: support updating known
 network settings
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231218141250.202157-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231218141250.202157-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 12/18/23 08:12, James Prestwood wrote:
> Currently if a known network is modified on disk the settings are not
> reloaded by network. Only disconnecting/reconnecting to the network
> would update the settings. This poses an issue to DPP since its
> creating or updating a known network after configuration then trying
> to connect. The connection itself works fine since the PSK/passphrase
> is set to the network object directly, but any additional settings
> are not updated.
> 
> To fix this add a new UPDATED known network event. This is then
> handled from within network and all settings read from disk are
> applied to the network object.
> ---
>   src/knownnetworks.c |  4 ++++
>   src/knownnetworks.h |  1 +
>   src/network.c       | 27 ++++++++++++++++++++++++---
>   3 files changed, 29 insertions(+), 3 deletions(-)
> 
> v2:
>   * Instead of bothering with individual settings we can just use the
>     new l_settings object. This would still prefer agent-obtained creds
>     set into the network object but also honor any new settings written

Ehh, I'm not so sure about this.  handshake_state_set_8021x_config() does a 
shallow copy of the l_settings object.  I think eap state machine will make 
copies of the info it needs, but...

>     to the profile if there is an ongoing connection. This is a much
>     simpler approach (unless I'm missing something). Only questionable

Also, netconfig_load_settings is called very early in __station_connect_network, 
so even if you overwrite the settings object here, it is probably too late to 
take any effect.

>     piece is what to do with the Security group. I hesitate to skip it
>     because its what we have on disk, but it could mean the network
>     object isn't synced with its settings. But I'm not sure this is
>     any different than what we have today, if a profile is modified
>     during an ongoing connection its settings (including security)
>     won't get updated until a disconnect/reconnect.
> 
>   * Remove frequency sync on UPDATED event
> 

Regards,
-Denis

