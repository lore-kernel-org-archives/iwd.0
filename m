Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2270D16C434
	for <iwd@lists.linux.dev>; Tue,  7 May 2024 16:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715098841; cv=none; b=qDxtMz/gLvbSWMRVhTWcaS0L3xhs87ApHcME5FO8tLVxU8L7eivu27BbDW9twLc0GPTmiMStMyenn8ulLQ9nHe0BKULoYRJ9kbj5YVCBQSrl3yqTIUoHOALW96hdiRBNEco+vGH46mUmuXxTlGYx3dZO9d7H9P38qUUx7UZKa/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715098841; c=relaxed/simple;
	bh=x3+y1NtX0Jo6N9A1z39bJyo1xDiVXYBuodhM9euWjeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JEfMUvbF3PaRLrCvIY2DcgAdmAShIfjYO4zDLq0hDMYSAqn+s0pSHJcvnh2wZuvDyPq3CqMs8CJr2UrUuOm3DSERUuF/raT9oXhyov8exq+3l+WYTdPYxJmv1ybcwWD4OT/eAsPewSsY00OewOsfTHL9USBsDk1Ajp4t/fltzZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6eeuqx4; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6eeuqx4"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-23eff8c9a1dso1940544fac.0
        for <iwd@lists.linux.dev>; Tue, 07 May 2024 09:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715098839; x=1715703639; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jpv9kXn3aYg5DIV3wki65ROxDre+RjNM83D7kLWGzqQ=;
        b=S6eeuqx4uGOZAo2nvwztAP/27uhxF2VeQdaulEi890ZIuvM7AoIaN4ZUp5IfxP39h0
         GGK0++h75h/cfRh0W2lKvCzpOHFRYGuz9tesL1EyvgzrxunnHuGx0nkYkJDbJJ3yGLt6
         z4ROr3TzMMPQZyRrZfaLRVpEv21ZcOtdVaJe28iMkOE1dY2VGdtPhNGGcR2ZdZmqb1q1
         5mCcu/IjhkpHd52FsYXWZNoVBmScwAVszFCv8VvhCShb9JHP0mVRG44Es3K3lsfcJQGB
         5tVVlyGflpvAfMs5MjmSAcjLfdSLAVWp+/VDcFwBCfnINH1+1QB49V2W7+YS6SanLD9o
         eUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715098839; x=1715703639;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jpv9kXn3aYg5DIV3wki65ROxDre+RjNM83D7kLWGzqQ=;
        b=VU4qCnYuFWVOmdENbw2I5th+jpPJfMaR9B/NYS1TeuMUkiXg7YP6FQH25t1nO641U+
         ByDFreVHSrjS+mgUj9WwK4FlZ0hovODPIx/d7RxPGz6a4iBAqr+U9LmHzmLqeWhtoTWv
         jRppPT1eChwf7wzPUS7B0nk6w1EJwEEKCBig1hcu6o5K+r0mci1HmeoX1bWgYmkWA/Ft
         lNvYs1dqRtmzKBSuIX6I79f8N9i/W4GFfIVGknLa2IByhJ9+lnDgsrySbui2eLetW+D7
         AAMY3B2clX95fgaXePr9so9+9WzFWVYJuPF4PL9xKyHTLIMviF9z7nG2vOCzoAqqfsC+
         V6dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIkTN474B/wPIh3bGR7Oa0OGyQATihONU7oG43puell/M7QueattgXbNSiiZiVqltdiR/jmxTX9fFhgdd1qAZ8QkSB
X-Gm-Message-State: AOJu0Yy9gt9qBglAMP5EsTDLXOalCrBZGx4ERv+T2tX2jyb+M7I97HU0
	ZYMecCjXJJX+acwd/w7isSWsX54VUulmP8jBObFp7+YvRVkqZ0KmqE323w==
X-Google-Smtp-Source: AGHT+IFMJdkX2cl19nSzBiw/zhX63HZZBKlHknFdGmeXoT+7G/76WG78A/qBAdvwIbe4KYpKp3MuVQ==
X-Received: by 2002:a05:6870:14cd:b0:23e:6f17:c27 with SMTP id 586e51a60fabf-24098a62c6amr58198fac.47.1715098839382;
        Tue, 07 May 2024 09:20:39 -0700 (PDT)
Received: from [192.168.1.20] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id o10-20020a0568300aca00b006ee4db9f637sm1338951otu.52.2024.05.07.09.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 09:20:39 -0700 (PDT)
Message-ID: <164aa459-1581-4394-bacd-72a87d31d2c3@gmail.com>
Date: Tue, 7 May 2024 11:20:38 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/18] eapol: include IGTK in 4-way handshake as AP
To: John Brandt <brandtwjohn@gmail.com>, iwd@lists.linux.dev
References: <20240506003518.320176-1-brandtwjohn@gmail.com>
 <20240506003518.320176-17-brandtwjohn@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240506003518.320176-17-brandtwjohn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi John,

On 5/5/24 7:30 PM, John Brandt wrote:
> When SAE with MFP is being used, include the IGTK in message 3 of the
> 4-way handshake.
> ---
>   src/eapol.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 

Applied after amending > 80 char line.

Regards,
-Denis

