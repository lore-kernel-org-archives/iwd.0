Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8681B85C9
	for <iwd@lists.linux.dev>; Fri,  6 Sep 2024 19:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725649264; cv=none; b=uIxiBqUxgpOEa4LYestSpJTNODarAtfmaNlzSJuF2mbfQOZdDQO20u3VOSZNvKSEMY8ZqCRy5f8Gw6O3pTCm/4gxERdRcTDPegjrUPcwfLzdoTKghTMoeLrNZJluI6KaIlYpsELLIHKpF++ykUeMKpp62WW71ezIMNudASBdV6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725649264; c=relaxed/simple;
	bh=LUH8XQwITNd3QFm5W/WUTE25or/kGAaeLNkGSnMUZCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RXCGTAEjy6MYfnNYmEYKyhOfNwa5BvdkZ+jaVwMAC6W/so1hLKxWFHdtZREXlsfixJOiwq40+mjYAg6jtWAsAvPYXdymm3rgWYef5CPDkOo45RSeDvP2/bO8PAI0u8t24JxgOxUadeMHLBacpwMDC2/VcbJXAb+MWukiA83GL+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxEA4J/v; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxEA4J/v"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2781cb281abso1472807fac.1
        for <iwd@lists.linux.dev>; Fri, 06 Sep 2024 12:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725649262; x=1726254062; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eXbpc+iX2gICpKjUNsP+8Q2xraA+p7QCWCoisqe3knM=;
        b=VxEA4J/vvH1yuMxJY8sn3erIIHvGZ6DIDcIA0hjdxKa7f307pwKCwLIUjtpn0NDtmy
         CZpdEKf5J+KapBABBCeWgfjrdEO8LdnlSCYON1tWIoudU2DmiYOibfh7KtDftgcL3Agx
         JkMLoaCZXBLA5xD6X8gsY3CM3qJxuQlcfcoH5NynD2vJvh/pdDuAh5yZdXBQobET8A0y
         11ToBaPU5FDud/S1HsD+ax/dMLHedUAExEo42ekms8Y5uGXs8/1u60sv03wSYIaZba6l
         D//gaz3XlS/ZFk9mqUCmRixBKBhV5MvbCLtn+9gd1i2eXHH9MSX0E/B/dkJkQfEQae1I
         +h9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725649262; x=1726254062;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eXbpc+iX2gICpKjUNsP+8Q2xraA+p7QCWCoisqe3knM=;
        b=a+VitziKPoVF12WMJ+j4kU/XU4Loz2YS+NrUdZpYJZ4Ng4Rc3Esv87P0+64jVxa6h9
         NNEB+xkqyX4qOsBydziUmLXF1z8Uw2ESfZg6LlSqjQ1+GWX3y6JXIenXJRWJJaJogtE9
         bB0X+Nh+qJMtj/9/nUA/7IrUGObEWcrmFC3noox+myHA6c6+nSXMOuYb9Zz8GBOPSe6x
         S9DIGm4cfrQd3hXukmDXP/Up14uSm8RMS9ohevjuFuWz0kQlGWbfUU7cPKNIeG00bnD/
         +BZntteoW0Evuvyovaoa+6xQPxGaAl9QRWn2GXy1evMYOxXqr06DeNz+uT99YK91B/98
         apqw==
X-Forwarded-Encrypted: i=1; AJvYcCXhjb13ix37T98DUwLdMLE3dUvQ8Ba4GgDphmYr/qZijenwhmdGmOSBPXwv0Qcpe4uLqAw=@lists.linux.dev
X-Gm-Message-State: AOJu0YyBQqVvcYkF2UCbpgCcPU7TmJZQawxcC99CP5BRNR7Mez2f/Uzb
	2eer9QSJlSVtbkiHLO30lsOlgVFen3WULCaMpjIxLy3GtQ2+OoX4
X-Google-Smtp-Source: AGHT+IGg6Qj4CJmEY1uwlysf6lo8wnzlkV45gyXb8QCF/df2qrpMQqeRFmfQ4+L44RbaIvj9nkI1Yg==
X-Received: by 2002:a05:6870:702b:b0:277:c3e6:7889 with SMTP id 586e51a60fabf-27b9d95eacdmr367913fac.30.1725649261651;
        Fri, 06 Sep 2024 12:01:01 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-277abb43db3sm4727071fac.15.2024.09.06.12.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 12:01:01 -0700 (PDT)
Message-ID: <4a5d7ca4-bd66-4f7d-8d2f-db7d86514d8a@gmail.com>
Date: Fri, 6 Sep 2024 14:01:00 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] scan: don't survey on external scans
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
Cc: Daniel Bond <danielbondno@gmail.com>
References: <20240905152658.380237-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240905152658.380237-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/5/24 10:26 AM, James Prestwood wrote:
> Since surveys end up making driver calls in the kernel its not
> entirely known how they are implemented or how long they will
> take. For this reason the survey will be skipped if getting the
> results from an external scan.
> 
> Doing this also fixes a crash caused by external scans where the
> scan request pointer is not checked and dereferenced:
> 
> 0x00005ffa6a0376de in get_survey_done (user_data=0x5ffa783a3f90) at src/scan.c:2059
> 0x0000749646a29bbd in ?? () from /usr/lib/libell.so.0
> 0x0000749646a243cb in ?? () from /usr/lib/libell.so.0
> 0x0000749646a24655 in l_main_iterate () from /usr/lib/libell.so.0
> 0x0000749646a24ace in l_main_run () from /usr/lib/libell.so.0
> 0x0000749646a263a4 in l_main_run_with_signal () from /usr/lib/libell.so.0
> 0x00005ffa6a00d642 in main (argc=<optimized out>, argv=<optimized out>) at src/main.c:614
> 
> Reported-by: Daniel Bond <danielbondno@gmail.com>
> ---
>   src/scan.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> v2:
>   * Disabled scan surveys rather than allowing a NULL scan request
> 

Both applied, thanks.

Regards,
-Denis

