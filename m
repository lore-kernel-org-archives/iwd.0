Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C45185B
	for <iwd@lists.linux.dev>; Sun,  9 Apr 2023 17:27:00 +0000 (UTC)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1842f69fe1fso3630677fac.11
        for <iwd@lists.linux.dev>; Sun, 09 Apr 2023 10:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681061220; x=1683653220;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rxJsa4J4ZeVaimSbuBx5BDk6rxTJywvyw+dSglpEvbg=;
        b=KM83I2uFe5uAxlp8JstgIMxeU6npp7NbWZuoI+l8rboE5T65pW/XzYT1fttwLGprfc
         9vouWf30efSHUZrrThzO+sRRlbIT/nBlQgxaxJRI13DJNBsHIg3iMptUzrbp0MP66Z5+
         9pXtkyLnXaQrH61UAKf9ZBFF/rmnU4EsIjm0Kuidh6GPZoombQvZZ4+/qvz5/ASbk65P
         dfPm4xOg/quHhV1eNuJWCPGSa+0XhjiXunXEWEGd2tCA7DJODn5v0cVGicALxn7ittxw
         P7eZPvs/fiLi7TB23kFiBjT4lElTnjBtqASrxNPkPGzwkwJ65YdCG4Z4anZKQR//tbCi
         Qv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681061220; x=1683653220;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rxJsa4J4ZeVaimSbuBx5BDk6rxTJywvyw+dSglpEvbg=;
        b=txYrpBzI1pNGlJhQWca9mTEA385MX4CyR5HF82NAHNkiMVpYQ4TcXK/fFcM/PwQ36W
         wOXP98FIec3XY+cuyfWdorirgWTM6X0Z7Q08rKkC0nQyNtszrLxkHFXa5dQx+PxWnjwE
         nqrKwrjwtBo7mGpHd1EFR3mR3BdyuS1/DscGmhOsUboZN2ilwRM9R5+fDwTnhUExM990
         BFrtiM2PVMkqE5iosrv5CYOS11MUvApRVtP91GemlGMzUNyQLpzgMvEEmfSErFO1y8Hg
         oGYhULB3HtiBAMxQEHwF2f2paC4Vleq5yj3WnCQuhz+uzHqjYpPBiJVqUDyRTTv7mMEo
         F2Ig==
X-Gm-Message-State: AAQBX9duYnUgC3cx4m/FeCKiKRSvq8D/YMMFFPttoFiGgw8m2H1EC/rm
	jqrfWERuhbI+8+FiKVL9ponaNDHYD8fFoQ==
X-Google-Smtp-Source: AKy350Z3Lckyenjgo1W2ALU6KdJ8I/nCEGuBT1un2g9x+jAxB8cryd64tuDRrBsjg/A9mpNhCVtljw==
X-Received: by 2002:a05:6870:428c:b0:180:857:d47d with SMTP id y12-20020a056870428c00b001800857d47dmr5049587oah.57.1681061220041;
        Sun, 09 Apr 2023 10:27:00 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id zr21-20020a056871ae1500b001765b2f6c53sm3372231oab.9.2023.04.09.10.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Apr 2023 10:26:59 -0700 (PDT)
Message-ID: <5ff7475e-9288-29c1-1c16-ab7e997541e2@gmail.com>
Date: Sun, 9 Apr 2023 12:22:34 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] eapol: warn rather than reject invalid PMKID (for
 EAP)
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230404203823.384260-1-prestwoj@gmail.com>
 <20230404203823.384260-2-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230404203823.384260-2-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 4/4/23 15:38, James Prestwood wrote:
> A recent hostapd change b6d3fd05e3 modified the PMKID derivation
> which breaks EAPoL if the FT-8021x AKM is used and the AP sends
> the PMKID KDE in message 1. This is because if the PMKID does not
> validate it kicks off EAP again to renegotiate a PMK, but ultimately
> the PMKID generation doesn't change so we end up in a loop until the
> handshake timeout.
> 
> The validation of the PMKID isn't really required since IWD doesn't
> support PMKSA, but we do it anyways if the KDE is included (why not
> right?). But now with this interoperability issue we have to work
> around APs incorrectly deriving the PMKID since its been in hostapd
> for quite some time and a guarantee there are APs in production with
> this issue.
> 
> For FT-PSK there is no changes required since IWD already ignores
> a mismatch (see comment about zero/random PMKID). For FT-8021x
> IWD will now first check if EAP has been exchanged and in that
> case ignore the mismatch and print a warning.
> ---
>   src/eapol.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/src/eapol.c b/src/eapol.c
> index 3d7d33e0..43f65b85 100644
> --- a/src/eapol.c
> +++ b/src/eapol.c
> @@ -1237,11 +1237,17 @@ static void eapol_handle_ptk_1_of_4(struct eapol_sm *sm,
>   			/*
>   			 * If the AP has a different PMKSA from ours and we
>   			 * have means to create a new PMKSA through EAP then
> -			 * try that, otherwise give up.
> +			 * try that, otherwise give up. If EAP has already been
> +			 * exchanged its likely the AP is using an outdated
> +			 * derivation, in this case continue with a warning.
>   			 */
>   			if (sm->eap) {
> -				__send_eapol_start(sm, unencrypted);
> -				return;
> +				if (!sm->eap_exchanged) {
> +					__send_eapol_start(sm, unencrypted);
> +					return;
> +				}
> +
> +				l_warn("AP may be using old PMKID derivation!");

Ugh.  Why not just detect that this is an FT-8021X AKM and compare both the 
'proper' and the 'compatibility' PMKIDs?

>   			}
>   
>   			/*

Regards,
-Denis
