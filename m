Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3097E20B2E
	for <iwd@lists.linux.dev>; Mon, 13 Nov 2023 15:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6kBAIgM"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3b6f4d8ddccso192769b6e.0
        for <iwd@lists.linux.dev>; Mon, 13 Nov 2023 07:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699888819; x=1700493619; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JUs6tHBp8wQrhkzojvKNA9DEFWn33NFlubfDIJVT7C8=;
        b=k6kBAIgM+iNCJEAQ6ALw1v/kVkSptRU6jZgfxxTicjkuG8DVnArd/UVY68eg6YfNBY
         oDs7ZIqWm6XL9Te3DbNpuvpZpxNLhegi84RCmwD8DSb/QfrmiAyuI969kjteCgzgFCDY
         6B9TGY6RO7L3GD+u9BXkrMnSexz/XxDjK2Xwu+vsBNzYR2IiVfExfayMDlbPVmeeGoWD
         +sfqKAG06pE31fNu/mcokkAdBmHNWPM9DP8WDGkAvrzT+ZLRec4m1DwlYm7gPxDHGRJw
         7h66UzLqIOFox3gsxbGVKYSejmMQ9LKedG8W40lz/Yu0eyujf1zHJGGzm36lhRlLyZDN
         yjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699888819; x=1700493619;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JUs6tHBp8wQrhkzojvKNA9DEFWn33NFlubfDIJVT7C8=;
        b=PIfaqoO29S8eyei7mh0vh5w7aNQrDVmMuPl2OuvmnmmCupFBsarWa2s5gMNcO0XeRC
         LNffcWafhmRsDmBn2ZhpEBS+WBRMiHFxGAs1h3aKAegjVZ425H4+sSrojT0OL0dr+w1j
         rHfVQChVKXNrQCVRIUwgOshYl8RMbWbk5wunpZFU772eHYRF23T777U0c2ebDu8Ah2kq
         zpaOe+dZnk47APqas4YM0bZpzSg2LvI4CLEv+xm9qOC2uRMx2/gc3Wl5SPcc7WDdiHhM
         DHMijkmqnCkLznPC+NAOldO2smQPexUtnM8ON2X5nZlPt2xa/C9tIVtBTtFINxT12JSQ
         hR0g==
X-Gm-Message-State: AOJu0YxHta3G48xCJYew275rY5J0iwYoilmRuBFruVP/Uw0R86deRNpR
	OvSoL50JWNq0lhrA1S399wk=
X-Google-Smtp-Source: AGHT+IEs97FK/X/kpHIB5R3FpzsaiwUHeWXBmoRl3QT78iKcLbtbnvgeescph08f/s+EQKf8hyJt2w==
X-Received: by 2002:a05:6808:2210:b0:3a7:7bea:d3cc with SMTP id bd16-20020a056808221000b003a77bead3ccmr8066707oib.0.1699888819173;
        Mon, 13 Nov 2023 07:20:19 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id e23-20020aca1317000000b003af638fd8e4sm828369oii.55.2023.11.13.07.20.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 07:20:18 -0800 (PST)
Message-ID: <3ad81a83-54f4-4482-9055-6f8ae40839bc@gmail.com>
Date: Mon, 13 Nov 2023 09:20:14 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] station: handle ROAMING state in disconnect event (again)
Content-Language: en-US
To: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>,
 James Prestwood <prestwoj@gmail.com>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>,
 Dimitrios Karnikis <DIKA@bang-olufsen.dk>,
 Claudio Cabral <CLCA@bang-olufsen.dk>, =?UTF-8?Q?Pedro_Andr=C3=A9?=
 <PEDA@bang-olufsen.dk>, Johnny Kudahl <JOY@bang-olufsen.dk>,
 "achyut.hegde@nxp.com" <achyut.hegde@nxp.com>,
 "yuvraj.singh@nxp.com" <yuvraj.singh@nxp.com>
References: <20230403141927.235014-1-alvin@pqrs.dk>
 <c9b5a931-ac35-2755-c656-acd567c1505f@gmail.com>
 <lrv3ytp7a6jvuupcu4pvx2w5jmud4yj6jxbk4imflcqeuosugo@vu7fco6auklk>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <lrv3ytp7a6jvuupcu4pvx2w5jmud4yj6jxbk4imflcqeuosugo@vu7fco6auklk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alvin,

> 
> 1. iwd receives a CQM event and enters roaming state.
> 
> 2. iwd issues a CMD_CONNECT. The driver defines .auth and .assoc ops, not
>     .connect, so it takes the SME path in the kernel.
> 
> 3. Auth/Assoc are successful and BSS1 kicks off the 4-Way Handshake.
> 
> 4. After entering eapol_handle_ptk_3_of_4() iwd asynchronously installs the keys
>     with CMD_NEW_KEY and then deletes the EAPOL timeout.
> 
> 5. The group key gets installed successfully (CMD_NEW_KEY returns success).
> 
> 6. In the mean time however the station receives a Deauth or Deassoc (not clear
>     from our driver logs) and the driver sends this to iwd. In

Do we know why?  And the Deauth/Deassoc is from BSS1, not BSS0, correct?

>     netdev_disconnect_event() iwd then follows this path:
>      -> netdev_connect_free()
>        -> handshake_state_free()
>          -> netdev_handshake_state_free()
> 	  -> netdev_handshake_state_cancel_all()
> 	    -> l_genl_family_cancel(nl80211, nhs->pairwise_new_key_cmd_id);
> 
>     Then, re: the original patch in this thread, iwd's station code ignores this
>     event, because the station state is ROAMING.
> 
> 7. The subsequent CMD_NEW_KEY then fails in the driver, but the above genl
>     callback is never invoked because it was cancelled.

There should be three NEW_KEYs generated:
set_gtk
set_igtk (if you have MFP enabled)
set_tk

Normally in that order.  Which CMD_NEW_KEY fails?

> 
> In this way neither the station nor the handshake code then report the error, so
> we get stuck in a roaming state.
> 

Ok, I can see that happening.

Regards,
-Denis
