Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AC52F2A
	for <iwd@lists.linux.dev>; Fri, 13 Jan 2023 15:17:41 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id f5-20020a9d5f05000000b00684c0c2eb3fso3332714oti.10
        for <iwd@lists.linux.dev>; Fri, 13 Jan 2023 07:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nRA/x/wnXLP0EWBKbI3Vt82c4Cr9VvGTOmn8DLs/wVI=;
        b=aeq5OwXIgmk9PYKs1Ou4ReUlgLk7Xsh593PIpE2NQZ8okyU2VEIIYcBYAcC5QtFbnP
         ydC4Szia6NOSFQ/HynPTvMouWqZGQJjneo7IJw+NgDNbvQk/ElLBXOq3/REdDXrKllGs
         W7O2aQ3PEhlrUgGUN0Buv2FxWv7Y1hyZ0+8QyDPT2wDhmw99zaKvq9N54HBeNkGS9X+X
         ebH2EATLz5C6eVpQ3GZAVAsMpzcX3L0NyVOfheUJiXvRtrYJtpH21ZhYXHFz1dQ47VOG
         OxM1OU7687R2vm42r1jTvnn8Qo+a3hAvKQB37M0Y85JBHAhcZzuaE+0mW7Yit+HhqhAU
         lhJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nRA/x/wnXLP0EWBKbI3Vt82c4Cr9VvGTOmn8DLs/wVI=;
        b=wdyu0UhmSNATOpd/lyHSgVeIeIbKoDBIxJChdZ7gKtT9YDkImO/PLBYB08DR3x5X6J
         bD2aV13gEZA95LA5EfQTUykO8YWmGTKaTKF8NfcgYZV196g+/A6+/ir4A1/lJo1svdq1
         fvSunosPWIbRGZ5PCLZEVBfTQ9xJGJjKk7JKwWocnkN1YLmN/6JpY27jnZPK4oG1Ujjs
         4+NDUfKMbgVZxDCxyPjZiZPDixhoxxyyqTVqs82S6cGw3HI3iGB8NM4qape9upS9o0OS
         fieu5cvont8g+DMLD2+6dikAW8krKkOWiecDPQbAPnZLlE/PbQuzQymopYB/ocRZMkl6
         FXqg==
X-Gm-Message-State: AFqh2kpAxln0xXAg0bt+ag/Uvu/loD9EvNMLeaLKhiGmVRvPttmobZrR
	A7VK6UCA2fQYlVhD93VRr2k=
X-Google-Smtp-Source: AMrXdXuX6V4vu4900mgWvxbLfxhvIQ3X88hzE4BtufCqGI8A9SMHb9HsDPaGYn9sxSdBYPGRnMM+zA==
X-Received: by 2002:a05:6830:6581:b0:66e:b436:d86d with SMTP id cn1-20020a056830658100b0066eb436d86dmr47450049otb.34.1673623060182;
        Fri, 13 Jan 2023 07:17:40 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id i5-20020a9d68c5000000b006718a823321sm10880094oto.41.2023.01.13.07.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 07:17:39 -0800 (PST)
Message-ID: <0893a530-d21a-0e44-0f1d-be93e1051f65@gmail.com>
Date: Fri, 13 Jan 2023 09:13:36 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/4] eapol: implement rekey support for authenticator
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230112193212.568476-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230112193212.568476-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 1/12/23 13:32, James Prestwood wrote:
> The only changes required was to set the secure bit for message 1,
> reset the frame retry counter, and change the 2/4 verifier to use
> the rekey flag rather than ptk_complete. This is because we must
> set ptk_complete false in order to detect retransmissions of the
> 4/4 frame.
> 
> Initiating a rekey can now be done by simply calling eapol_start().
> ---
>   src/eapol.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 

<snip>

> @@ -1111,6 +1109,12 @@ static void eapol_send_ptk_1_of_4(struct eapol_sm *sm)
>   
>   	eapol_key_data_append(ek, sm->mic_len, HANDSHAKE_KDE_PMKID, pmkid, 16);
>   
> +	if (sm->handshake->ptk_complete) {
> +		ek->secure = true;
> +		sm->rekey = true;
> +		sm->handshake->ptk_complete = false;
> +	}
> +

Hmm, shouldn't ek->secure always be set to sm->rekey?  I'm thinking of 
retransmissions.  Lets say we start a rekey with eapol_start().  ptk_complete is 
true, so the first transmit of the 1/4 packet will set ek->secure to true.  But 
on subsequent retransmissions, this if() statement won't be hit due to 
ptk_complete being false.  So ek->secure won't be set properly, no?

>   	ek->header.packet_len = L_CPU_TO_BE16(EAPOL_FRAME_LEN(sm->mic_len) +
>   				EAPOL_KEY_DATA_LEN(ek, sm->mic_len) - 4);
>   

Regards,
-Denis
