Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2453B1E47CC
	for <iwd@lists.linux.dev>; Fri, 13 Dec 2024 15:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102464; cv=none; b=ejxRMYtmhDRwlW0UiaLyeDGVPRxmZrHeUS8JGZb8piQxOAvHMKcXX88+YBpNU1mVgHq3lFfVVhB5StGCwk4BUmyTQJM1EkY310WV7QYH3BMJgijaT5de56HO9fhRaTzXg6HpCdfLjt1aYD8UTonSLzQ9zrPB7EaXa9rv0HKC7DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102464; c=relaxed/simple;
	bh=0Y3Na/ov6peXJTBYXHscxmw6JuWVOn6B/uDQMKdrUuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ScJa+bAFrJXUQjHsds1lnlCtfrJeINKIFYtKFMp3tQMagkKfcxicC42rkATLB6uSsQ4/fm+l1zAm/nxovfA1fqAqSKRiiPE0ESb/8m8fDDI/prmuPaEJGPfAV8eeY3qWTI7WSliDMUD4b+xSiX+OAeQnoIxIKUE83to0M6v3s30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jz6gCXKA; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jz6gCXKA"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-216395e151bso12556105ad.0
        for <iwd@lists.linux.dev>; Fri, 13 Dec 2024 07:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734102462; x=1734707262; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=izdCRuQ3wwzuj6R3lsC/3/hcHWRTgfUvf6q5CM96HWY=;
        b=Jz6gCXKAMsYEHWvnaBn9GPlE/MjI6rangeQk+KIX0+XBZ6Y/TnEkzafP9maiyJCeta
         ZCznCjIXlbMGqQVXVHVZq/ZX+Vr0hXSz+N2Sc1ih1qXjczWOZt1dFGpfDR6qlz8CbQeW
         R+hwF8srCpowZP/pNdUOkRsNA3/FhXt39R3eBDXs94zsw0wTAIFcm4kB03fUsuW1PTPz
         22RlX4C2i+QEMUv1nWue+RBXKaFqE+g28eAKhnArcxnoTH7A2Em5EU4naXwrkxbaTl8I
         6Gml0S5jBWYHNCB6qp/8XtQhK1wBKJjNRVu3Hgt+I81SHQ0N7y7LXBfmm/k4+08cde8/
         UiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734102462; x=1734707262;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=izdCRuQ3wwzuj6R3lsC/3/hcHWRTgfUvf6q5CM96HWY=;
        b=TZckO7ohw/AEFh+rIyEo8GG0sajx8Sir4QBdFyhhITIBDxQUkqJDCcPXJjBtPBMKZG
         E1Jf2tcelon9Yv+Eyjbs+HXktO/BY5E9IWlh40ODXRwYAJ2MYBslmKIB68C6avEkjazl
         qdXBK+rU+GLdX3NCLIaTBS+UFaMOffTTgJEVbxcC2VB+MUINxFwIr2FMvk1KOq4VU475
         1vademJEC3HPEuLGtTj88uBSSbVg+futIN43U+EiBliSdulL4ytZ67X+OrIhb1lyEi7l
         0x6WDR3JPdkB+AMXQIxUB/iHXsc5hFp+DbImdq1rlicYZdZyiZ4OLF4wsbLN+UBGJ9p6
         sRCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWezowIr5GhpPNTyR5+5j7NatSZS5FqVEAT9aYMDDOR9Xjf22AUzqZKGvtM/vv2/mSW0g=@lists.linux.dev
X-Gm-Message-State: AOJu0YzUMV5+MYprDZjcUKq84wkkdqHNvVkjZVOztLnMP+qBMCO6YxUk
	t/lAz00kT5ltZljJZWdu5zbG/etou+7A8RVwxoUba0i0PzXP4lS6SvfbYg==
X-Gm-Gg: ASbGncubL+9/+yiqfEx+vLYPG6srAgm9Kq9KKSVeDEmyWSohff3EzWXiC9EhFPZZJ/a
	IdQfV3uanPsL6VqKtdunJQ6gCpBJUvH5bbDigZ8kewDXJGNkU9KxOym0S9ixJ3uFZtLbknOCqbM
	A5ijuAYOl3I1ioExOmEW+hnCYiPYWQSnpYKkeR04CQoZf1ZBA2bOrvjtuqifrGCw/rLDeY2obvN
	+T1DWDwMhs5d2eifNcRUqHACrcM3RucNftZKXZkeXFn/EZJRoKOorsc+Hs4
X-Google-Smtp-Source: AGHT+IEiaBzAd30clLEBjWVFQeYJ/ki6Zizdfim+R4lL//FXw9SYoa9aVVAF3k0B3m7AVsyEEVJ4vQ==
X-Received: by 2002:a17:902:da8a:b0:216:4122:ab3a with SMTP id d9443c01a7336-2178c7b6821mr115740655ad.1.1734102462160;
        Fri, 13 Dec 2024 07:07:42 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216426f8ca4sm93730495ad.278.2024.12.13.07.07.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 07:07:41 -0800 (PST)
Message-ID: <3b4500af-2981-435c-bc4e-e1ecfd8da96d@gmail.com>
Date: Fri, 13 Dec 2024 07:07:39 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question on documentation for Enterprise network configuration
To: Michael John <MJohn@midmark.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <LV8PR08MB9350F57066DF7E632045D03DAE382@LV8PR08MB9350.namprd08.prod.outlook.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <LV8PR08MB9350F57066DF7E632045D03DAE382@LV8PR08MB9350.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 12/13/24 6:56 AM, Michael John wrote:
> Hello,
>
> I'm looking for configuration information for WPA-Enterprise networks and I found this
> page on the wiki but notice the banner at the top says this is out of date.
>
> https://archive.kernel.org/oldwiki/iwd.wiki.kernel.org/networkconfigurationsettings.html
>
> Where could I find current documentation?

Most likely that stuff hasn't changed. But the full docs are part of the 
IWD man pages:

$ man iwd.network

>
> Thanks,
>
> Michael John
> Midmark Corporation
>
> CONFIDENTIALITY NOTICE: This message, including any attachments, contains confidential information intended for a specific individual and purpose. If you are not the intended recipient, you should delete this message and any disclosure, copying, or distribution of this message, or the taking of any action based on it, by you is strictly prohibited.
>
