Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AAB376FA
	for <iwd@lists.linux.dev>; Fri, 15 Mar 2024 13:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710510600; cv=none; b=Kc+4jlmNt05oPvofg2/X0+617xVwCSHr5CUV4SttGBk4TPhdsNe4X1iOs8zhlGFc9KLSMzbj1/YapUCe11Wy3QFFbHd4RxZeNlKpWQCANGmIXcH8aQ2+ULi4fBmzDeGnH/nHBFkUO5YUpkoVFXpxH8u8ULdNN7r102/jz3V4/nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710510600; c=relaxed/simple;
	bh=X8GQI4fW0QTMk/yD2nJgMfU1C6tODOe2f9ospCdKdaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VVHL4hSNo0E2VfDMWL9W49B9AC4rMk1kL0PAGrCdYIp18r0TpOfCwLWMjHLuDfo7q0baDEiA9q9dB0IhIrDvfcV7Phgq2Oob5k7Dl7Q/I79ha4DMcIMl3hqzEgLgTaVhHdDsReq7rLJ6hxqpbfAqWXDV6MJjWVJ5An5ZbMyLJC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dq3R0QsG; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dq3R0QsG"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e50e8dcc72so1087696a34.3
        for <iwd@lists.linux.dev>; Fri, 15 Mar 2024 06:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710510597; x=1711115397; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yTMTixya5hRXh/ImjWMys1dwFAUT2tMxiYIniRXk5GQ=;
        b=Dq3R0QsGTQuLuAkx4TDYSJmnzr4vyQQzXR6J5C6sWPOvSp1FJ31lWPqUwuZC5IRDIt
         lGE0nj7uqV6tX9KJY/W6rIyvfGr0CFiAmvNsFTH/5w4YXN1r7JztAxQB7lPlRgrP3wFC
         yHa4442joJmdwhzvqDYmmybtDGRtVXSc04CToHsa6LcTBtV/h7UsKnZifYc1GM4kA8IY
         WRKD7wpQET3kEN5P2l/zlEII7dEW9pE9wK/9W0sBBiYNHRLe7JtGjAXXfuluF2Mwtjsh
         VdCJ8L+6wlgmBUHj/5y5ARIEuA+KPMNYhgA76GIf+mUKlOERoCCxKUkVPcvmL9iuMTSp
         ts4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710510597; x=1711115397;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yTMTixya5hRXh/ImjWMys1dwFAUT2tMxiYIniRXk5GQ=;
        b=h1RDSftY38KN7AWg0Ww+h2bq6uDE4tvlFzXoKAZwVuCVdFtpmnNl2QMZz8bpm92vao
         LUnlpM4Ez19QsDnni7M+bFsUunlSrMoJh3ywrVwWY3/NqjAFpmqtNqLp5GR3rPemRh9J
         Q1FoIV50YD3HwaxxNpkX/tnEpdlF5EnQj/5DhDNKz7hl2lyH6GX8E8Tk02lW4M/ybRp/
         vQOqA3w7oJYQ+3l3QN1Gal4VFtAp9KOdSvPIXsZgI7j2l8GnfknnGJvseOJmzMfjlBuD
         O3DeEwWF469gu74ClOJiPhfcP5NhzbvLvpyDeDtTjqK1cjD7qTGqBkrddtn26sfyE77i
         9vkg==
X-Gm-Message-State: AOJu0Yw0wIIs8AL5STZtrfCh/LvRVvu/C4RKhXwgOPETsp1x3s2SFjf6
	8p8++4aZKU4jtqDxrXxG7TEwRedyrMfiaP8wn/TEl09pbECgBfA3
X-Google-Smtp-Source: AGHT+IEYYF1gsQv70HtGm7F1Qe84J7lQBrxEBLtPUcHDYugqLQvJt1HyNdz5R7R6+5a8Awq2OojqQA==
X-Received: by 2002:a05:6830:22cc:b0:6e5:3210:e8f5 with SMTP id q12-20020a05683022cc00b006e53210e8f5mr4877756otc.22.1710510597557;
        Fri, 15 Mar 2024 06:49:57 -0700 (PDT)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id f20-20020a9d7b54000000b006e4dd2d119dsm668583oto.71.2024.03.15.06.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 06:49:57 -0700 (PDT)
Message-ID: <8ce688a8-8cc4-4651-a0e5-ca20f86c8888@gmail.com>
Date: Fri, 15 Mar 2024 08:49:56 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wiphy: include libgen.h to fix implicit def. with musl
 libc
Content-Language: en-US
To: Clayton Craft <clayton@craftyguy.net>,
 Marcel Holtmann <marcel@holtmann.org>
Cc: iwd@lists.linux.dev
References: <20240212184747.30422-1-clayton@craftyguy.net>
 <8b02ff06-9c2b-4503-8fb8-9784c2628394@gmail.com>
 <152B8E7F-C6D0-4827-AC38-25454FD6BAF7@holtmann.org>
 <f9970105-c1c7-484b-8e13-5ca5f5bae901@gmail.com>
 <34797D3A-D630-4D71-B4E8-BD29E9BB759C@holtmann.org>
 <b1b66222-6594-4775-94ed-2f17810029b1@gmail.com>
 <BC62FEA8-DA18-4084-A5B6-A96C82AE799B@holtmann.org>
 <a64273d2-e585-4e48-a35a-38384b79202c@gmail.com>
 <440488C8-0481-4A8F-BF68-A7F97FAADC8C@holtmann.org>
 <20240314153055.GB8925@craftyguy.net>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240314153055.GB8925@craftyguy.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Clayton,

> 
> Thanks Marcel & Denis for the replies. It's not clear to me what needs to be
> done to resolve the original issue I set out to fix with this patch. Could you
> please summarize this so I (or someone else) could try to implement it?

Should already be taken care of by ba5a6df2d170 ("wiphy: Remove basename() 
use").  See [1].  Part of iwd 2.15 release.

Regards,
-Denis

[1] 
https://git.kernel.org/pub/scm/network/wireless/iwd.git/commit/?id=ba5a6df2d170fce96354f0c9ba281fe049d2f0a3

