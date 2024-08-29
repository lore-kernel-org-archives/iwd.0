Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C5B1B012B
	for <iwd@lists.linux.dev>; Thu, 29 Aug 2024 14:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942447; cv=none; b=IvLMXU9ITPAkBOw097HgbwHUw1CNNbnoFBxnuqB6lhtUYdMf3Rz2epUPqZUYVFOy6g4hasEQ097Jd5QXX+bGvLRSIQkjLut1NVy2WAR+lG+vTLnghC8W40vFSSvqs7kId7LgmEdinzJ3w4iSgkLob3fTnEGqZ4AjLhSTrMEfCTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942447; c=relaxed/simple;
	bh=gPDVDZJ9g4lh4JFijGaOo4IB3/gOaGXtaT3xES4FVw8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:
	 In-Reply-To:Content-Type; b=pbWRh+FFyN5YaQkHVldmX6KC8mV2SgBbZh6f/Cdih+o+fCb4g2kIYoubq2DlRMO3qvCQmdL79SvYDOXPKv0+ljjq/Ly+EM1PvnYtNauvRVuwPEZBDNWUPUZa1IuSE60DLWg5xTmzGz/+aRQQXHzEs6qV3JW2X3GgDncy+su9jys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7t4Br+F; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7t4Br+F"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-202089e57d8so5592465ad.0
        for <iwd@lists.linux.dev>; Thu, 29 Aug 2024 07:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724942446; x=1725547246; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/pMUjD9XkAbJVRH6gLYyFYhzWWCcAfGJMPCJpXwc+DI=;
        b=L7t4Br+F9enPoIbQeyvTlk34DJrfNfdCDc65nIokY0ySSJYl0sRCb2zyJ+nejcYwQY
         34kSgsvAvlO5K10l9hBc2Bivh3b9AclsYmxeshxSbZBLPktyr/J9/s/tGGmck38rgpyM
         BVmKmARsvrcqlUPPNfqeAqsIL7LByB0WbJWFsmWyhwB3I55dy44EbUHaPD98Y4jVbyTM
         6vCYCl8jK8C13zVtckGe1my1QhxXxka8SL92+DjBPh2mVARzRlY2qtSykKdeRHpUXYYA
         9svqMD067/z2q8hghUlci1nTH1gx54BILI+vQTv4pHD9Jh3WvJPgIZa31c8WEKlr2Zwu
         0tXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724942446; x=1725547246;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/pMUjD9XkAbJVRH6gLYyFYhzWWCcAfGJMPCJpXwc+DI=;
        b=r2jsPCl8GxnqlKVwSTuIxYMxf7f0wPzOEZHvpomO2piyO+5CQOTuPE4FydgTUxRpPK
         nAVIomVvTKVe0AWK2W/AVxXdGZIAjnQCM2UAsfJ2aq9tGP0AqWaUfZeBC2HEHmiIgReD
         N2UlE5LqSvCum2NkxYEtQWfLJHF74o3yP5hPjwn2lqeWosmsUBjlaKRbWqMe5bUNZ1rY
         u/CFa/KN4lXJnFFPnuysman9rH8pqHHELmOEzUlLgzjrBhScOl064uz5yKGgR633Cd1l
         esq2CfI351YCzmXEXXw5nyOEQnjjlmonB4eXEt605OglxI/zFm/Zsvk90uA4XYDqcOI9
         igYA==
X-Forwarded-Encrypted: i=1; AJvYcCXLOsn6RRd+YN0sD66A8sdFkCHdOVgRy5IDVCCxCee53n7b/Hmh3b6WYAZA6D3bRXC41aU=@lists.linux.dev
X-Gm-Message-State: AOJu0YxB1krmAmI3TRpDMh/VMRMQDYv6yGHWicR8hEQKphtQxNTSfDyn
	5TWrXWnHMwiC6SKxDh/MafH96Qsmq6QmNCd+fyikZ9lXAr2uHJQ4
X-Google-Smtp-Source: AGHT+IF64wcgcQctErLR0SVa6+cOGZvqEZX1V0f7lOuYfMPlHG9xKEsJd3nyNkXqWjgAV4wAOWS8Ww==
X-Received: by 2002:a17:902:e952:b0:1fc:4acb:3670 with SMTP id d9443c01a7336-20516734701mr26025205ad.12.1724942445412;
        Thu, 29 Aug 2024 07:40:45 -0700 (PDT)
Received: from [192.168.0.154] ([115.187.48.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b13c9sm12122225ad.62.2024.08.29.07.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 07:40:45 -0700 (PDT)
From: bbhtt <bbhtt.zn0i8@gmail.com>
X-Google-Original-From: bbhtt <bbhtt.zn0i8@slmail.me>
Message-ID: <b247da3d-ce86-497f-94ab-bcd5d2d2cf70@slmail.me>
Date: Thu, 29 Aug 2024 20:10:42 +0530
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: bbhtt.zn0i8@slmail.me
Subject: Re: Build failure with GCC 14
To: "James Prestwood - prestwoj at gmail.com"
 <prestwoj_at_gmail_com_gebvfb@simplelogin.co>, iwd@lists.linux.dev
References: <520f3ed2-79fe-4b91-9442-b219cb00732a@slmail.me>
 <eaa91b3f-b8af-4c6a-bf40-6613d80d4ff5@gmail.com>
 <de9ff462-582a-4a62-a669-7cf49e53fb27@slmail.me>
 <d10b9c12-25fd-4e58-9ab1-061af4a3b09f@gmail.com>
Content-Language: en-GB
In-Reply-To: <d10b9c12-25fd-4e58-9ab1-061af4a3b09f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/08/24 18:56, James Prestwood - prestwoj at gmail.com wrote:
> As of 5 hours ago, we have IWD 2.20
> 
> https://git.kernel.org/pub/scm/network/wireless/iwd.git/commit/? 
> id=1ac3915641c9fc986cf71fc8de2740104da6a96a
> 
> 

Thank you, that seems to have fixed the issue for me.

-- 
- bbhtt

https://bbhtt.github.io/
