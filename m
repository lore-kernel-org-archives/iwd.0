Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95AC3D65
	for <iwd@lists.linux.dev>; Thu,  8 Sep 2022 16:11:39 +0000 (UTC)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-127ba06d03fso22063352fac.3
        for <iwd@lists.linux.dev>; Thu, 08 Sep 2022 09:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=qchLKsllEzRulBTJK2kcJW8ua9hOv0sH3+hGWsb27+I=;
        b=dcW5VTagE/XDaigxJxl0txDinly7vc6XBBslnCrNGS7R8nd86U1bJYpV9avLqpxnJy
         4QCq3uVA6ltVZZuGISLZJ9LMv4JK6Ksi6bXbHQOoT+Esuu1Jmeqtw5xdG2KXb35Z1Oq/
         oCy0IwlAK6SLEpzXAfBL3owGOJu29G1xw9mcmogLMa/vhaKP6qa7yTJJV6/5iqdMEDYn
         x7QvwHdrbO6XlqE+q2OrYbA4sWyqsA/k3Rjz4SowWMUC85vqfjrrwdV2g0r2AOEpG8BS
         Y69xoMXPZ2VW/OemhANBR6tN2xdXHVD96EWcVvJKev3PJlcNJNS/h7ubdjpfLdCJ7Io6
         p+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=qchLKsllEzRulBTJK2kcJW8ua9hOv0sH3+hGWsb27+I=;
        b=Y+n3aE9OkDbZNpvKcXm4a9jL5UntdE4dsm1ekntCg4TN9riDs83dnvToUxpIt814kZ
         42XerVU0Glz0ayIwqBBAN1vDVH5n7wTA0MEs2TArKiwGSdjJLosS7/OInkpJ6VOTqP/e
         Z2j7zT4l8vaxmv3w2oktrAp4kyi8FJqy2CGCbkcU5ZlMVkeixMnqAUSoB4hYtfUqYKJ5
         L35rIpZ8BhJIttEIdjfhaNg0A85mmnKXg7Gph+VWBZz8WmHBOpeFUOlF1YPw1m1m7vdf
         RZ4+9lAE+d6+VNUf6Mt5ih+M5HOjGvLJwCkDCXdy1MrCabjcTd4b5t2EJb6gd9AMDSIk
         pVMA==
X-Gm-Message-State: ACgBeo1CwwNmrH9qoJJk6wzoY93mKgxzTFYJgcx01bJ7WdHzfhW2re/h
	mA+bWpTmJDWnDmXH4B7fthqKtpQ3Q60=
X-Google-Smtp-Source: AA6agR4TR8ZJ6uRFrlw5KJ4BZau9btfRFUuvAf0Gd3c9spkqNt8S5cMW7sP1dhZvxMlLPE4Ul5LVkQ==
X-Received: by 2002:a05:6808:14d0:b0:345:309b:4abe with SMTP id f16-20020a05680814d000b00345309b4abemr1811118oiw.296.1662653498764;
        Thu, 08 Sep 2022 09:11:38 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id x12-20020a4ac58c000000b0046e8d284170sm1470751oop.41.2022.09.08.09.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 09:11:38 -0700 (PDT)
Message-ID: <3c5ee36a-8971-119f-dbb5-9b7556ea3f4c@gmail.com>
Date: Thu, 8 Sep 2022 11:00:57 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/4] wiphy: support country code override
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220907233201.227577-1-prestwoj@gmail.com>
 <20220907233201.227577-4-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220907233201.227577-4-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/7/22 18:32, James Prestwood wrote:
> Depending on the device the regulatory domain may never get
> set on its own. This is worked around in wpa_supplicant by
> allowing the user to supply a country code. The kernel
> _should_ set this on its own based on the docs, but ultimately
> will fall back to user defined if the driver doesn't set it.
> 
> IWD now needs to work around this problem by allowing users
> to supply the country code in main.conf.
> 
> A few notes here:
>   - Setting the country may not effect the actual regulatory
>     domain. This is because the kernel still remains in control.
>     Any request is merely a hint to the kernel.
>   - This only applies to devices under the global regulatory
>     domain. Self-managed devices will not allow setting the
>     regdom.
> ---
>   src/wiphy.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 79 insertions(+), 1 deletion(-)
> 

<snip>

> +static void wiphy_setup_reg_domain(struct wiphy *wiphy)
> +{
> +	const struct l_settings *config = iwd_get_config();
> +	const char *cc = l_settings_get_value(config, "General", "Country");
> +
> +	/*
> +	 * At least do basic validation. If this fails force a GET_REG but do
> +	 * not try setting the domain.
> +	 */
> +	if (cc) {
> +		if (strlen(cc) != 2 || !l_ascii_isalpha(cc[0]) ||
> +					!l_ascii_isalpha(cc[1])) {
> +			l_error("Invalid setting [General].Country=%s", cc);
> +			cc = NULL;
> +		}
> +	}
> +

So why is this override being done per-wiphy detected and not at global level?

As far as I understand you can only set the global regdom.  So this should be 
done in wiphy_init or better yet, inside manager.c ?

> +	if (!cc || wiphy->self_managed) {
> +		wiphy_get_reg_domain(wiphy->self_managed ? wiphy : NULL);
> +		return;
> +	}
> +
> +	wiphy_set_reg_domain(cc);
> +}
> +
>   void wiphy_create_complete(struct wiphy *wiphy)
>   {
>   	wiphy_register(wiphy);

Regards,
-Denis
