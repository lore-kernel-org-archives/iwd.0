Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472391A0701
	for <iwd@lists.linux.dev>; Thu,  5 Sep 2024 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548272; cv=none; b=aWu1bM+JhOeLv09Un2X80rrpqGFu+uaU72aEYuttKcZyfR195uO1TnDzpUeUCJaI3a6k0IUXeV8BfmaXkSvTVuf+UfsgUQl7Shso6FpYyRVFkCh6eZC4TIzYWMdrPQK5UA1T1TvZLKHCLa/QSXw9j/LRe7j9vCZudew0cJax0dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548272; c=relaxed/simple;
	bh=w/wvcMtqDHTJ4nONzsreq2Xlpe6eEMBl0bhCQKtPCjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KivB8Ibq2hBFfqnnRiS4vu58bMT/j/0ndiDMtlxfDDk4imEzCOXCK2zX8xugBlWy9/YXGY+isR7sOTwN5Nrh7f9J57cAj0XRxhPRfzg52yHuUv0nM4yVI0KZlr2zk1f8pUOIYm19s/3sJneRzC9nZjoc4t+PbX2irSGT/Muri6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2ZwcQRg; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2ZwcQRg"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2705d31a35cso603415fac.0
        for <iwd@lists.linux.dev>; Thu, 05 Sep 2024 07:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725548270; x=1726153070; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A5GKhs5Kv3uOuExO2qc31M5CG54L/C5P3zsFDLbZFSE=;
        b=d2ZwcQRgAbyVmPE2sTgDFWUIpGVr4GOT5Ghtxm6vDNjqOog5vx8NWwOfCcDrgrrytj
         Jm4+FuGq1SqrUrgShZwwkwfs79SwhTXYsmRrl01t1eG8TeEynieenzl/E4s7YwvbAie0
         n0fWUy0mAGEDO29D2e+iGpnkPZga/6wl5HgGQ0UvVGQYFmImg9ouj+4ujEKKU7iqg9q5
         QuH+UqQzQwgHXKfccDsmLs/o44HgBe2i2qnjS/mVfnbM4C77NCxz+O/k41mda9Ububgq
         gc6RV3kIKsYCLa71MVqDEbxdcZP4iMEcKZ1ktk3kOyFZh8q5h37R1/JFUDUiUsaMz7lG
         0N4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725548270; x=1726153070;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5GKhs5Kv3uOuExO2qc31M5CG54L/C5P3zsFDLbZFSE=;
        b=soH9/1uiZd8BuUBq2FPrsZ+IK+DyNkHKoz+S4rbR3IAjvEvgF9XRHQHIN+ORoHB/YI
         YZzqfXAHXPjF4rN+QgcLZ6NrGKXECqE183DJrSXJgFFqedUBHvwhC1nlo6KVePj/FPVJ
         eccM4Nrb3RET5qAZ+VDk6YafCcjp/1zhXUUgNMg9uqaJ0pztTWx3zA4VvUgMo/UEw5Rn
         43QR7Ku+9I+tuo4Ug19IWB0WrWtdHub9YAmT9b9c/hiVcPsrpdjirEAg2MGl6qOXEaVs
         x/pj55wc2G2v+fKFcD+7OX9Gdt+todP65xnB0vP0NaMgHrn3Tpm0TTX66JR31XsxeXzN
         mKVA==
X-Forwarded-Encrypted: i=1; AJvYcCV/XZGiFXQFMrMOmip/GsLHRzIboBp96iYHZVQiICveSFmYX3lPx/I65e3wG0cC6+J/loM=@lists.linux.dev
X-Gm-Message-State: AOJu0YzzM13/8uM4rxCPhPhjlQJHk1crJXtiD7XKltyp7TxPVLKt1gFp
	wh52kS+RoLIfqr6xXAE/d+/QHLJRpTAbPTiTIlLdsE6uWic5YYsq
X-Google-Smtp-Source: AGHT+IGeGWdalNo4DY9kq9OvV6SJv/xpSdUl/AJYRSn70LJ99Um3OjBPp/g3Gk5nlQyUKxdNxz1EeA==
X-Received: by 2002:a05:6870:808c:b0:261:1f7d:cf70 with SMTP id 586e51a60fabf-277ccdcfcdamr20401536fac.36.1725548270244;
        Thu, 05 Sep 2024 07:57:50 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-27b660050d4sm504072fac.11.2024.09.05.07.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 07:57:49 -0700 (PDT)
Message-ID: <4d66fa8f-7499-4d68-9087-6e3bf6aa876e@gmail.com>
Date: Thu, 5 Sep 2024 09:57:48 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] scan: check scan request in get_survey_done before
 deref
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
Cc: Daniel Bond <danielbondno@gmail.com>
References: <20240905134315.374800-1-prestwoj@gmail.com>
 <fb4b3b86-e659-448b-bfb9-cfba35c2b87b@gmail.com>
 <1fc65fe7-3e6f-4953-973c-84bde72bb2d1@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <1fc65fe7-3e6f-4953-973c-84bde72bb2d1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

>> Do we know why external scans are happening?  I can understand a one off 
>> because someone triggered iw scan, but from the bug report it sounded like it 
>> was crashing iwd repeatedly?
> NetworkManager? wpa_supplicant running? I really have no idea. Either way its 
> out of our control.

Would be good to know and fix that.

>>
>> I still don't understand why we're even bothering requesting a survey for a 
>> scan we didn't trigger?  In other words, we shouldn't even be in this function.
> Because we still utilize external scan results for periodic scans. So if 
> periodic scans are running we will still try and get the survey/results.

Should we though?  I'm not really sure how surveys are implemented at the driver 
level.  Are you sure this isn't introducing other timing problems?

Regards,
-Denis
