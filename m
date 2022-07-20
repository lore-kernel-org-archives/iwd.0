Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F3D7465
	for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 19:39:41 +0000 (UTC)
Received: by mail-oi1-f179.google.com with SMTP id bb16so12133511oib.11
        for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 12:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=jHqj3gADKUHv+pnFM0u7N6OrNdIlejPTDgod3aVbGts=;
        b=H9DvTxwkngsjKb/Ucfkgr1zzasGaNRTN4Fa7ciq47nCw2JNJ4kv7LFOY/567VWd2fL
         7i7NO632hHEVov6ydefm/RdEyah40QZNC5j628YogK6T+DP1sGM7Cm6nnXDoOaA+DT7r
         3N3lQ0DzqwHrM147Fg37uaIaIMjzBMTBopWsH+RtVRVmx9rhJVyg6jtuQoUosaPV3bLc
         m7Wr8IDBx304aPD4MNqgNYnRXjcRF9cm3KyTElDd5agtrXfAm9rj8ES5a5lPKxdqLJIi
         Q6NyY/tmCkUjaJ0zDn+/hxjYSCPuVoscEDdt+raZ65ECrEFVuVeYxAY6HK4GlOD9XnXF
         8r2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jHqj3gADKUHv+pnFM0u7N6OrNdIlejPTDgod3aVbGts=;
        b=uegdBW7ROHLgt0RLCeNv4AD5Ic5nUoP2xn0J92LQjJ2qc+udEpC6N0WW531GOqnSRw
         leTOCuysDhWJL2BiJxyK9Cdk+xd5kJo42VUsy6MgBOotFgIlzPiKE2Vu6fa+CLvkS4lE
         CK6W7LvKxp/x83zFyrKVS2vPYKv2r9fqQ1X/DqNy0IxKf2ZXXd8cfJ4ngv248T+LfFWk
         UJpXWguLPH90p41n46PPpjkzZDNXrD4VgXLs0z7sQjp1CNGMllP04zrGAUbvhA5Kz3CP
         yRpiQo1oUKqmEEWLnlw4Bs+YZpVX7tCiE1bjJn2vPTjLsFX0x1YoWDDtCZMUR4/qunxP
         4Cmg==
X-Gm-Message-State: AJIora94Ihi7zImpIbzZJaDdYHwWm1aPZ0CPbnXguo6zkPqibvSPJLmK
	nFyHXPs+aK4mO1/GRg3J6KAQnE9pdVs=
X-Google-Smtp-Source: AGRyM1vIpUfhLLx4nPK9mKcCi0jkiSQmR4xDUhsgbTdz81FI4hgD9qPNkNcKRfaeidSE4B22HRvhBA==
X-Received: by 2002:a05:6808:209d:b0:33a:8b99:f7a3 with SMTP id s29-20020a056808209d00b0033a8b99f7a3mr3096882oiw.119.1658345980489;
        Wed, 20 Jul 2022 12:39:40 -0700 (PDT)
Received: from [10.0.2.15] (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.googlemail.com with ESMTPSA id m6-20020aca5806000000b0033a7a2d5e7dsm3275232oib.5.2022.07.20.12.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 12:39:39 -0700 (PDT)
Message-ID: <7e37dd69-88bd-afa4-d52f-984b3f651aa8@gmail.com>
Date: Wed, 20 Jul 2022 14:20:28 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: iwd fails to connect when passphrase > 40 characters on 5Ghz;
 times out on 2.4Ghz
Content-Language: en-US
To: James Tavares <jtavares@kvh.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <E34D86E6-F357-4233-A698-C0EAC029F431@kvh.com>
 <e74694b1-f62c-f430-6c2f-32d275c61763@gmail.com>
 <caccaddd-4d7e-11e3-5aca-3d7b6c8e40da@kvh.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <caccaddd-4d7e-11e3-5aca-3d7b6c8e40da@kvh.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

> I know I sound crazy, but, length is playing a role, somehow. I did a binary 
> search on the passphrase length to arrive at this 40 character limit, and the 
> results are very consistent on either side of the line. With more testing today, 
> however, I did see one instance (out of about 10 tries) where 40 *failed*, and 
> one instance (out of about 10 tries) where 41 *succeeded*, and so I'm thinking 
> 40 is not a hard line in the sand. That said, it always works with passphrases 
> say <30 characters and never works with passphrases >50. I'm thinking more race 
> condition vs. say, buffer overflow.

This seems unlikely?  I'm assuming you're using WPA2 and not WPA3.  If so, then 
the PSK is a fairly straightforward transformation.  Refer to:

https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/src/crypto.c#n548

https://git.kernel.org/pub/scm/libs/ell/ell.git/tree/ell/cert-crypto.c#n107

The passphrase is simply fed into the kernel via SET_KEY operation and 
hmac(sha1) is called repeatedly.  Hard to see how passphrase length can 
influence anything.  You should be able to trace this via 'strace'.

> 
> Is there any chance that the increased length could be encroaching upon a 
> timeout? For example, does PBKDF2 computation time, or some other part of the 
> authentication process, scale with passphrase length? I agree timeout is a long 

It should not.  The passphrase serves as the key.  The number of iterations is 
constant.  The PSK is computed before the connection attempt, so timeouts 
shouldn't affect anything either.

> shot, for sure, as the CPU is a 1Ghz ARM aarch64, but I'm grasping. FWIW we 
> don't have any SIMD (NEON) accelerations enabled on this processor, and so lot 
> of the security primitives are probably un-optimized. (I mention this because I 
> notice your test harness cases enables X86-optmized primitives in the kernel).

You can always try pre-computing the PreSharedKey (for example using 
wpa_passphrase) and see if the computed PSK works?  See man 5 iwd.network for 
details of the 'PreSharedKey' setting.

> 
> For the record, for password entry, I tried all of the following, with the 
> similar results:
> * copy and paste into iwctl
> * hand-typing into iwctl
> * hand-crafted .psk file, for example:
> 
>      [Settings]
>      AutoConnect=true
> 
>      [Security]
>      Passphrase=00000000001111111111222222222233333333334
> 
> (Copy and paste that exact password into my Mac's authentication dialog, and it 
> works every time).
> 
> Also, when switching password lengths, I made sure to forget the network each 
> time (which deletes the .psk file, as you noted). Per your suggestion, today I 
> tried restarting iwd and the Router as an extra step, but that did not seem to 
> make a difference, either.
> 

Hard to see what could be going wrong?  See if you can come up with an 
ssid/passphrase combination where iwd computes the PreSharedKey differently than 
what wpa_passphrase computes?

Regards,
-Denis
