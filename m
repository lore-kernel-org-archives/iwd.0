Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502F316078B
	for <iwd@lists.linux.dev>; Tue,  7 May 2024 15:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715094446; cv=none; b=jgqOpfmRCer77/q5Hbddxl1ixHpCbzjsuvBwSF2iJ0/woNLlJnV9PYiQJyZlzI52xxvAn6MUkhowJruCQWe14z3ktxNh0UYzQOoNa9Ov3mVA4sXgjsjUBD15hzFsitERK7OhSJ77TwCtHknUTaAZwhCFp6QOpvjMBmmsoQe3l0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715094446; c=relaxed/simple;
	bh=JosTvr1kjVGe7gZpmiKVolRR/avYZHSG3lclk9W0QE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kaNw6BfxxpRDjagkNNQWczhku/SL3nzQFXgUcwam8r3Bt+7toq4/K/CVY656Av3TUihkY+qr++6El5XsoppGcc0k1I1QnofKSHhafXUcakT8TPzk6syliJeM7kms8YUtmXhMwYG10KW0oDvmD1d74bwdnT//tgLKY8DcUsPYMYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWNJD4QB; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWNJD4QB"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c9539d1bbcso2609123b6e.1
        for <iwd@lists.linux.dev>; Tue, 07 May 2024 08:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715094434; x=1715699234; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hh2yhrG4Ll82ibdR2c28INCin1mNMP32LexBhj6JwFI=;
        b=eWNJD4QB5ZOY1HB+go1lVeLaaNrA242nH1Yu66FazV0Kp7DAzmdlTteX1B27RvWF1i
         XpzGpXsJAJz7jyPJaP9mA10NuuKDTJ7Tvo7rI/h28wgHAzZn+qsx+2EaezBPwNx4kzQ0
         578YZU+giZJwAgpEF1sYW3PpdSMOlr9PfJuasvcu6XLA8IQsilGa0swjePt5/hdG5SjI
         OC9KQS8KdFNhiYM2eYtKlFry//daGY/aifBisZQtHzdv9ie/lCiTJYIor+dmOLTxTkpg
         S3vuUPqrEftxxZwSee/1FGP0kQi/4AlyqMzdUZU5v5XZYBcDWsvpcDYachmHF04Z1ZKB
         GJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715094434; x=1715699234;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hh2yhrG4Ll82ibdR2c28INCin1mNMP32LexBhj6JwFI=;
        b=OczyIITay7f9rSNyYURl/IIWBf+uhA3ip42wDqMxMIucDBhv3qqB+n64/oyjgt328I
         oqhZZcGojvJ0sIij5bgNAN4cJVkd6dewXbM4K5CrocJHXd9b/63DcZdOdnBe3hbC58ra
         7tBJ6HAAMsi4b/FibjgUxb+/YKEBAeeEupQJtuTx/CPr/xe4h7IEWB05DW/o+3h6CLq/
         Q5WU051Yzspgz7QTNIwkVTotzFjU0GSqD/51S2Rz8YLvBfOkOExMrKf/ed+gr8+z42Kh
         LBbsgKUHDq9U3jVZ8iv1IcYBvfw68QgsczZZ4vdiVxV/oPZO7cS5XCM/gSI60wugluug
         GdJw==
X-Forwarded-Encrypted: i=1; AJvYcCUGSX9hOCnmmtiGMcubjnW0yMQxXua8vNnatZRgs7BhS6iXM5YXTvy5EDjUKIuBOvLuXthi8awYbSvO+B8mRjtcZ1Bf
X-Gm-Message-State: AOJu0YxjftNJcl7NCKkf4x10aVUmrI12d4C7d52n0tOZ0k+6yuYwZHFc
	LcfxNzXomIIFyz2lJGz8dWl+iSAKjWrEDhpQYTzDG33oaFA0w0SqosHRtA==
X-Google-Smtp-Source: AGHT+IFB0gbqkINEYcKjXBGLNag47vSH6GSWfO94S1fYCEc9+4ApDG5bXV2oVX8c6UNsor26lr4+EA==
X-Received: by 2002:a54:478b:0:b0:3c6:ce1:d25c with SMTP id 5614622812f47-3c984b882e5mr39980b6e.15.1715094434329;
        Tue, 07 May 2024 08:07:14 -0700 (PDT)
Received: from [192.168.1.20] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id fb16-20020a0568083a9000b003c82cfb1a5asm1853619oib.28.2024.05.07.08.07.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 08:07:14 -0700 (PDT)
Message-ID: <b9ade3bc-d1ae-4650-827a-c14f10d49106@gmail.com>
Date: Tue, 7 May 2024 10:07:13 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/18] ap: accept PSK/SAE in auth depending on config
To: John Brandt <brandtwjohn@gmail.com>, iwd@lists.linux.dev
References: <20240506003518.320176-1-brandtwjohn@gmail.com>
 <20240506003518.320176-3-brandtwjohn@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240506003518.320176-3-brandtwjohn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi John,

On 5/5/24 7:30 PM, John Brandt wrote:
> On reception of an authentication frame, accept both PSK and SAE as AKM
> depending on the config. Save the client's AKM for later use.
> ---
>   src/ap.c | 29 ++++++++++++++++++++++-------
>   1 file changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/src/ap.c b/src/ap.c
> index d50f9e4f..cd253ce3 100644
> --- a/src/ap.c
> +++ b/src/ap.c
> @@ -132,6 +132,7 @@ struct sta_state {
>   	uint8_t *assoc_ies;
>   	size_t assoc_ies_len;
>   	uint8_t *assoc_rsne;
> +	enum ie_rsn_akm_suite akm_suite;
>   	struct eapol_sm *sm;
>   	struct handshake_state *hs;
>   	uint32_t gtk_query_cmd_id;
> @@ -2606,6 +2607,7 @@ static void ap_auth_cb(const struct mmpdu_header *hdr, const void *body,
>   	const uint8_t *from = hdr->address_2;
>   	const uint8_t *bssid = netdev_get_address(ap->netdev);
>   	struct sta_state *sta;
> +	enum ie_rsn_akm_suite akm_suite;
>   
>   	l_info("AP Authentication from %s", util_address_to_string(from));
>   
> @@ -2627,17 +2629,28 @@ static void ap_auth_cb(const struct mmpdu_header *hdr, const void *body,
>   		}
>   	}
>   
> -	/* Only Open System authentication implemented here */
> -	if (L_LE16_TO_CPU(auth->algorithm) !=
> -			MMPDU_AUTH_ALGO_OPEN_SYSTEM) {
> +	if ((ap->akm_suites & IE_RSN_AKM_SUITE_SAE_SHA256) &&
> +	    (L_LE16_TO_CPU(auth->algorithm) == MMPDU_AUTH_ALGO_SAE) ) {
> +		/* When using SAE it must be COMMIT or CONFIRM frame */
> +		if (L_LE16_TO_CPU(auth->transaction_sequence) != 1 &&
> +		    L_LE16_TO_CPU(auth->transaction_sequence) != 2) {

Can we use sae_verify_packet for this?

> +			ap_auth_reply(ap, from, MMPDU_REASON_CODE_UNSPECIFIED);
> +			return;
> +		}
> +		akm_suite = IE_RSN_AKM_SUITE_SAE_SHA256;

nit: doc/coding-style.txt item M1

> +	} else if ((ap->akm_suites & IE_RSN_AKM_SUITE_PSK) &&
> +		   (L_LE16_TO_CPU(auth->algorithm) == MMPDU_AUTH_ALGO_OPEN_SYSTEM) ) {

nit: Only tabs for indentation please

> +		/* When using PSK it must be Open System authentication */
> +		if (L_LE16_TO_CPU(auth->transaction_sequence) != 1) {
> +			ap_auth_reply(ap, from, MMPDU_REASON_CODE_UNSPECIFIED);
> +			return;
> +		}
> +		akm_suite = IE_RSN_AKM_SUITE_PSK;

nit: ditto item M1

> +	} else {
>   		ap_auth_reply(ap, from, MMPDU_REASON_CODE_UNSPECIFIED);
>   		return;
>   	}
>   

Regards,
-Denis

