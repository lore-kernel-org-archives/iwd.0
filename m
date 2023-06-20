Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C035010E3
	for <iwd@lists.linux.dev>; Tue, 20 Jun 2023 01:55:54 +0000 (UTC)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1a991886254so4383337fac.2
        for <iwd@lists.linux.dev>; Mon, 19 Jun 2023 18:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687226153; x=1689818153;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Btc7gfiVy+BF5W9Spc6i341KEqBikvQOKdyHCxk4Teo=;
        b=lMNtzy/FpbcuilePchitfo1XsC9MO8ElGLOX4UEvKDnT4S7TDWJZ+t682nj01DSLBp
         seq6gik+v8mp1ZH9dsY2SpP+nklAvTPcjXgtyw0ubji1wpGBzIgpQhp6t6QVTytSdF56
         lMftqDnavF0TzzG7/LeajK3PV0LMPndcBXwRZxgRuRP5OCwddTeeZ5MmGlbTGL7sFoCv
         nkF9m96vyrf8Zb1EyHT/ZAEre0KrH3GIbbuz+c2X47zwLa9Rajex/Mxg+iLex3SbPeSt
         9Ss90p0SBh7dWnF3MsB3+nn73ANsrKY1yQBJAy3TZfknzHi/+fa+r2O/mIkFi2TAg+5D
         J/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687226153; x=1689818153;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Btc7gfiVy+BF5W9Spc6i341KEqBikvQOKdyHCxk4Teo=;
        b=RmKDMDDSmTletcbxZZnCnj3zDVUjn5jACcIhWiG3tBgfmtfMA2SFrwd3yJUiK2ZcwG
         Uo7w4HFV0LFxWWPjzK8mIt0U78v2Pf66U7Q9BNO6/zI0hVoXNVubAvwh1Ucz027xyFCq
         rAiOCgAPVvUsM1i3EAQinqHMOVCPRNiESNw6OdN2MQYrAAXM0/hPQsGV5oRwYiQdOxlC
         IhhaS2wL+sKzHIiwhUmSHQqaVAuxeBqt/hCxtIxtyYXaaSzuUP/XThg9LTwg0LinIgYm
         14cFL8CLFH4PObV1DDao/iPTADvjlDe0oRNydPI62vPxaKg6FfbeYrfykQgZ8Bh9wS1e
         rTSw==
X-Gm-Message-State: AC+VfDy7g/AqrrweyhvSQWEJp2RQszJhh12Dq6LD7xW98St66FaxK6sJ
	wpDYleVnCQeYGSBEfcCGgLRy2tpDA2k=
X-Google-Smtp-Source: ACHHUZ7o9DJmo5FRkf3aYXbm/kYw4WIBR7dcJRx22GXqeIhnGU7L5kgIEeYK8ZMKZIOhHicjTF02mg==
X-Received: by 2002:a05:6870:4c2:b0:177:dfdb:63 with SMTP id u2-20020a05687004c200b00177dfdb0063mr7994500oam.44.1687226153572;
        Mon, 19 Jun 2023 18:55:53 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id k3-20020a056830150300b006b2ca17623fsm442474otp.64.2023.06.19.18.55.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 18:55:53 -0700 (PDT)
Message-ID: <c4716c1a-bd81-cd3c-de6c-0fc89ab4666d@gmail.com>
Date: Mon, 19 Jun 2023 20:53:56 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/6] handshake: add force_sha1 flag to
 handshake_state_get_pmkid()
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230619225746.462791-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230619225746.462791-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 6/19/23 17:57, James Prestwood wrote:
> To prepare adding FT_OVER_8021X to the SHA256 list for PMKID
> derivation, add a flag to force SHA1 to be used with
> preauthentication. The spec dictates that preauth must use SHA1
> but this isn't consistent with PMKID derivation in all other
> cases for the FT_OVER_8021X AKM.

Can we port some of the long-form explanations from discussion we had during the 
previous iteration of this patchset.  I think some pointers to relevant sections 
in the specification would be nice here.

> ---
>   src/eapol.c     | 2 +-
>   src/handshake.c | 7 ++++---
>   src/handshake.h | 3 ++-
>   src/station.c   | 2 +-
>   4 files changed, 8 insertions(+), 6 deletions(-)
> 

<snip>

> @@ -734,7 +734,8 @@ void handshake_state_set_pmkid(struct handshake_state *s, const uint8_t *pmkid)
>   	s->have_pmkid = true;
>   }
>   
> -bool handshake_state_get_pmkid(struct handshake_state *s, uint8_t *out_pmkid)
> +bool handshake_state_get_pmkid(struct handshake_state *s, uint8_t *out_pmkid,
> +				bool force_sha1)

I think it would look much better if we pass in the checksum type here instead. 
That way eapol can simply hard-code the value to SHA1, and other callers can 
invoke a helper to convert the AKM into a checksum type.

Could also simplify crypto_derive_pmkid as well.

Regards.
-Denis
