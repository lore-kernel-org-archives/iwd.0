Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652AB23A0
	for <iwd@lists.linux.dev>; Thu, 21 Jul 2022 04:25:52 +0000 (UTC)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-10d6e8990b9so881035fac.7
        for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 21:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=zL/WcN39tzkG6KhE0XIVUHLLfz4+AR2Jkl+wvP50QeI=;
        b=QvHdeWWyeoFKgKx+WasnbR6wpbDDD81466X3N6Ec2FOFqOFfXBok5/SVplW1rWMmUB
         7nka6Ps4K43ydgZLFrlETW9ttX0lqC2TIOdB+En67tqf9ORvVYTN3F0VKXBuc57emBW9
         5KHIz4fZS7zcHhkiNPKornk2cgocxC3S4ywd7isoDAHTES7qgbTtXNkZB678OosHz2Nz
         oTb+lBBiam3i1uSHvi1YOwnidqwb5YyZozeRt09TLNaVL+KYyxqoQ8FgsXg79nrwLIc9
         O5+9OMk9Or/r7tizH5S6TYK9FY6zXLW2AfVFonvVhR5NZ23xLyDB7Ixmd9bU177Y77bX
         RgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zL/WcN39tzkG6KhE0XIVUHLLfz4+AR2Jkl+wvP50QeI=;
        b=5sOLazABXm5mRz9A/MK45ug1LRE2xv1vYNVuHqYVswslJkee6WJPYikBjaY3P3Xxs6
         lXIhyRWYaHKHOXr+e6svcTFrsxKMpN+wXwdVR3c1Ta6zFF2f10ugiC9wTUKpRy89Dc3/
         BLX8kaUj7pCHVhlGenS+TcznM4x9YhlAxJOQtbcw4pgtHeKZo5u7c3dvLB8ncPV6F1CR
         3VaiXYXDUM1EC2hQI5vKJrP7nczioj7GLeML/hliJ7mm7hwL6RUFizaud2Z3a/Hg9mJf
         +yUxm6IS1ijB9sVZhbuXwSJsXFTrg4vvnQyuAkCwHJOtIHOzmtN9CtlKIVPE5ANR2l/b
         wP4w==
X-Gm-Message-State: AJIora9UqjU84QjD1V2AiY9tXQ0jFn6ZTWe9C7nedN23DmL26JffXo5e
	P5Vb5Mwo7OTNfVP/WUlnUeo=
X-Google-Smtp-Source: AGRyM1u2KUDgExTfPpSfy1KonAm6M7+VWufT2G4WsA4PymwoFfL+gdYCdiinAj47G1cPFaIMhopxWg==
X-Received: by 2002:a05:6870:5b91:b0:108:374a:96b0 with SMTP id em17-20020a0568705b9100b00108374a96b0mr4347707oab.126.1658377551511;
        Wed, 20 Jul 2022 21:25:51 -0700 (PDT)
Received: from [10.0.2.15] (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.googlemail.com with ESMTPSA id k23-20020a4ad117000000b004359b581401sm375500oor.25.2022.07.20.21.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 21:25:51 -0700 (PDT)
Message-ID: <daab977b-fdf1-274b-0ebd-45d71b090500@gmail.com>
Date: Wed, 20 Jul 2022 23:20:08 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] tools: Add simple utility to generate the PSK
Content-Language: en-US
To: James Tavares <jtavares@kvh.com>, iwd@lists.linux.dev
References: <20220721021314.14066-1-denkenz@gmail.com>
 <b240184c-d90a-db5f-e7f0-ff2c5b432e6b@kvh.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <b240184c-d90a-db5f-e7f0-ff2c5b432e6b@kvh.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

> Awesome! Thank you. With this, I was able able to confirm that there is
> indeed a problem at the 40/41 character mark. Passphrases of 40
> characters reliably produce the same pre-shared keys as wpa_passphrase.
> Passphrases of characters 41 and greater produce random pre-shared keys
> (although they sometimes repeat, as-if there was an uninitialized
> memory, alignment or aliasing issue?).

Using your 41-char example:

denkenz@localhost ~/iwd-master/tools $ i=10; while [ $i -gt 0 ]; do ./iwd-psk 
ShortWiFiName 00000000001111111111222222222233333333334; ((i--)); done
PreSharedKey=64f0097675bbe0d4c316bdddfff3321fc39dbb11d2a629ff34cd1ee74ac112c2
PreSharedKey=64f0097675bbe0d4c316bdddfff3321fc39dbb11d2a629ff34cd1ee74ac112c2
PreSharedKey=64f0097675bbe0d4c316bdddfff3321fc39dbb11d2a629ff34cd1ee74ac112c2
PreSharedKey=64f0097675bbe0d4c316bdddfff3321fc39dbb11d2a629ff34cd1ee74ac112c2
PreSharedKey=64f0097675bbe0d4c316bdddfff3321fc39dbb11d2a629ff34cd1ee74ac112c2
PreSharedKey=64f0097675bbe0d4c316bdddfff3321fc39dbb11d2a629ff34cd1ee74ac112c2
PreSharedKey=64f0097675bbe0d4c316bdddfff3321fc39dbb11d2a629ff34cd1ee74ac112c2
PreSharedKey=64f0097675bbe0d4c316bdddfff3321fc39dbb11d2a629ff34cd1ee74ac112c2
PreSharedKey=64f0097675bbe0d4c316bdddfff3321fc39dbb11d2a629ff34cd1ee74ac112c2
PreSharedKey=64f0097675bbe0d4c316bdddfff3321fc39dbb11d2a629ff34cd1ee74ac112c2

Not sure what to say...  Maybe there's something subtle being triggered by being 
on ARM? Kernel bug?

> 
> My other observation is that iwd-psk (@ 0.450 seconds) is considerably
> slower than wpa_passphrase (@ 0.017 seconds) at generating a pre-shared key.
> 
> 

Yes, that is something we're aware of.  Kernel doesn't have a native pbkdf2 
transformation, so we end up re-trapping into the kernel many times and that is 
slow.  Hence we cache the PSK for subsequent connections.

Regards,
-Denis
