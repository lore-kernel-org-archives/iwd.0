Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A048C1D55A
	for <iwd@lists.linux.dev>; Thu,  2 Nov 2023 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBT/9N6f"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3b2df2fb611so731764b6e.0
        for <iwd@lists.linux.dev>; Thu, 02 Nov 2023 09:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698941428; x=1699546228; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rPxrSJdtRV5+5hyM214FWyVuJ5dJUNa5AF+wgRJfRhg=;
        b=QBT/9N6fKTV9v7XUcFp2rRQGjbLGJUJh+s3k61Kj/c0KR92Sr/zoV7tAC/wBfItfo6
         rVvSZMo5pOfvGhJ5dImqaJIxyxYrIjDc/6PvnALbF/OwJaIEpSbVsIjzbCZWtTZX5VeP
         ZNB1uoLAf4aQnUUUpiJTRSjM/RBRpOqJCGRn/wuBTDGQQpnfhnmyctNuW8GUI/FrbtT2
         NZKzXPyjPKZ3HzwxRmEsvXLkaAAg4Q9/H/jJSjobRqLaixONqqzlOCcweQYRV8iq93+l
         n6ULxd/PJnXdZsl7Sz5aMaTy08XSv9r4dgpKWvwHsb5dlnQuzWxyKzn2qGBSvHn+8QFv
         FXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698941428; x=1699546228;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rPxrSJdtRV5+5hyM214FWyVuJ5dJUNa5AF+wgRJfRhg=;
        b=aUJL3RdafQAIh2LhK9cJxQhzpXsluYXV3Mp5Scvymhym/TkUcWMragURPLWrpeqmsz
         +l8MFqhWxZFLeA1D/AKgKi0tqxsTdCDLwVVNSnju9SnfchrLOgTm9GsLnvnX5FWLaBsX
         T6JNdO+tb7vbSZkmfnuow+ITwj0CdoZ4XvZ6ghI2cLrZMWNCZGRupKl84fwsupZJ901I
         aTOlbsGfPW/+t6Al+PT+VdliUiPcsCCsMJRT346TZCGyUnvCSpJjHa5j5NAsxGmF4mdO
         2n5lnO2yLSPWc3uBTLE3/+sWyOGcYFSkccqo7b4f/nKm33S51WSRKte9lf3EmeC0ugUI
         2Jkw==
X-Gm-Message-State: AOJu0YzVtdEhMxgbYn2tvo3YUutYmg02gjKA8r+S0Q0+RNQTUCCeB1TY
	3K04ErpjSrbrKA7TZy3AIVY=
X-Google-Smtp-Source: AGHT+IGDvNEJC4z7QxKGVEDMwVyLTF1/gaxj1UspXdFo+0+4oFej00/wvxki8lJaRXHSTq2sUPKiuQ==
X-Received: by 2002:a05:6808:2102:b0:3ae:2bc8:2b93 with SMTP id r2-20020a056808210200b003ae2bc82b93mr26647401oiw.3.1698941428670;
        Thu, 02 Nov 2023 09:10:28 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id j12-20020a056808034c00b003b2e4754cc2sm576652oie.26.2023.11.02.09.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 09:10:28 -0700 (PDT)
Message-ID: <e93105bf-c3ad-45bb-8f52-3eac5035bbae@gmail.com>
Date: Thu, 2 Nov 2023 11:10:26 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Packet/beacon loss roaming improvements
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231030134837.452957-1-prestwoj@gmail.com>
 <b5138012-c4aa-40bd-892e-5b578a29ade4@gmail.com>
 <0cf695c9-7abc-40e9-a6fa-fdd10589839b@gmail.com>
 <fb8dfeeb-3f5d-49d2-8a4e-063b4933d905@gmail.com>
 <70935a8f-1f38-4e9e-8d77-40179c2b31f3@gmail.com>
 <68d50637-4b8d-4690-bfac-e379e1044492@gmail.com>
 <d5be907b-5790-42da-a17d-6ded2f9562a6@gmail.com>
 <27703a4f-a071-4ff7-afbc-8dda1c5b0b27@gmail.com>
 <be09ed30-f92c-4f9d-897d-77d9d5f7a919@gmail.com>
 <16ab09cc-0ba9-4c01-9f92-47e05aac2160@gmail.com>
 <424127a9-af47-4a15-91f1-ff97e7ceacc8@gmail.com>
 <99451a2d-7b3d-4927-a733-a86e58c81a4d@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <99451a2d-7b3d-4927-a733-a86e58c81a4d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

> 
> I wonder if we should be limiting both known networks and frequencies in those 
> networks. We do push new frequencies in order that they are added so it may be 
> nice to just pick the first 5 or so in the queue. Then we'd be capping 25 
> frequencies at most instead of the whole spectrum in the worst case.

We should, but we don't track them in LRU order at the moment.

Regards,
-Denis

