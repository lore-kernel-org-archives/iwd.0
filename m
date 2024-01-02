Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0148C15AC7
	for <iwd@lists.linux.dev>; Tue,  2 Jan 2024 17:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVznpgFp"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bbd1e9c5f7so3645758b6e.3
        for <iwd@lists.linux.dev>; Tue, 02 Jan 2024 09:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704215417; x=1704820217; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xOqM8U4mgc/5qLT0W1X+5q3TgSK7frwy2RYaa9H0OHQ=;
        b=fVznpgFpO6WsMpfs42vaXDQp2jsuAuKGF7Bs0flVgCA/DfaC1mo4BEfFVqzMvMLj2y
         S6cDWRTW9dQSBVfmH/ALZj7pkcxQXrFpb2j9w0uMvwlVQvCqO8PBrfcG6Ql7wxlrdCnY
         KUT8IuiymkZyiaqrXKHcYqG0uhDWqd6Dm8RaVvP94K+HbGWG6xHsQWuTJCiXzTHh52t6
         IpdCAFum7c6RgaIWw9tRLo3ORQ2LJ4/TdlsPwz3QiDF7GXFlc2WjScLtWs229xU9MZBz
         ixWuhedP4kC9JeclgdlbS3sFSuTiug2FmaKpioPhhDQmNDzxj2SHFpnLWLj6aVIQey+3
         UDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704215417; x=1704820217;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xOqM8U4mgc/5qLT0W1X+5q3TgSK7frwy2RYaa9H0OHQ=;
        b=C9ql0BP5LQ+nGtQcz6XU6Xobs/7Radtvs/hPwhlY5wWan6LqqdzaKm3QIhXX5boxQB
         YZp53jkABE0dBFLteeCukxUO0OlZ5qLPf79tntvIk6Y0kQ1KiB2ZZRgRlp8/+U/oodAm
         i6bsRWrFEN9FhTfil1+sxEBN2A/5Z1YMaDeewsfU2/TQcCR6nkWfODGAf67z/ypGWUa5
         R4zzQuQ427qcULD5X7y36FaQZvSlPzqInKVW5NfBvujOQQvtXPhPceT0nbZcGZiSwcFm
         cgqx9gJtVv3rRLfnAv5L8ww+2PHSjYn0bWyYRkJodgSjcfGsW52RsretsjfH/cze1tEX
         IzbQ==
X-Gm-Message-State: AOJu0YwKADrESuOxfsnX43dAaVe9/f4ZA/v1Vyqwf2U+9LiZtb0RQeq1
	E9+iCtGUKXrK691Tbz2vaQ0=
X-Google-Smtp-Source: AGHT+IF89VQfuRSm+aGIUR9bBdKhILO/rJHfBkY/qVgsaAxNBJm6cGgPIVsJGhHzFKZLzpEb24BZmQ==
X-Received: by 2002:a9d:7f0f:0:b0:6db:e15d:4238 with SMTP id j15-20020a9d7f0f000000b006dbe15d4238mr8451286otq.70.1704215417010;
        Tue, 02 Jan 2024 09:10:17 -0800 (PST)
Received: from [172.16.49.130] (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.googlemail.com with ESMTPSA id k15-20020a056830168f00b006dbde059c81sm3010672otr.70.2024.01.02.09.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 09:10:16 -0800 (PST)
Message-ID: <dadf5399-4c77-4b99-b2a4-3ed2f18c7bde@gmail.com>
Date: Tue, 2 Jan 2024 11:10:15 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Setup help request
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, Mauro Condarelli
 <mc5686@mclink.it>, iwd@lists.linux.dev
References: <5b97b06f-5047-4a1e-958d-27a6185ba504@mclink.it>
 <a345fe93-149b-46d6-bc00-ac35bb302858@gmail.com>
 <f477c1f4-4585-4b76-95a6-d0d31532e401@mclink.it>
 <b3c259af-ee4f-488c-ad81-a734302fc6d6@gmail.com>
 <2aaed79f-9fae-4750-8e85-994a48a45da1@mclink.it>
 <bf00447d-9817-4bd9-ba67-149356d6ecd6@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <bf00447d-9817-4bd9-ba67-149356d6ecd6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

> 
> I'll need to look more at the spec to determine if this is "illegal" (for lack 
> of a better term) to duplicate these IEs. There are some IEs that we allow 
> duplicates of (which you can see in that patch). With a simple search I cant 
> find anything in the spec that disallows duplicates specifically, but we have 
> this comment in IWD:
> 
> "Tag found, make sure no duplicates present unless allowed"
> 
> Denis, any idea where that comes from off the top of your head?

802.11 allows some IEs to be duplicated.  For example, see verbiage in 
802.11-2020 Section 9.3.2 dealing with Beacons:

"One or more Multiple BSSID elements are present if"...
"One or more Emergency Alert Identifier elements are present if"...
"One or more Emergency Alert Identifier elements are present if"...
"One or more Vendor Specific elements are optionally present. These..."

Regards,
-Denis
