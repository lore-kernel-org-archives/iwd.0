Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280CE28DB3
	for <iwd@lists.linux.dev>; Thu,  4 Jan 2024 18:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlnyUiQD"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6dc83674972so425101a34.1
        for <iwd@lists.linux.dev>; Thu, 04 Jan 2024 10:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704391210; x=1704996010; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BVzRNwO6orYLZOBm+2u4IpNhvDs0H+m+8ake6ZYVEMY=;
        b=TlnyUiQDLHKPFU3Oq4w7fiRZlliBJmAPCc0nOQE2GnrzTA1qKR82tLikGtI6hQGjxi
         WF+8T3m9X6K2LZLg6ZNj+S78yOyACZKXeibsEIo1F/JDAA9sZdGCbDkiFllCFnirlt+a
         eLYkzC70SLxn7/rbStHxufOfszJ6OMn2766fQUXBg6OWhWSkwAevC9aCpbxnkUUBtodO
         JgXNdQ5WRQvRXqVQWtKY6VbnrquLeNZkf5juH6D7DF45V9FUi8ZergupTGPQbjUyo3lB
         /Iv9TGdYR3kiR/85CAKIlEUmDSAs+7PkN/O/YJ4A8P827vwv/uTDeQyKqu5pd9r7Ztfa
         3Zkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704391210; x=1704996010;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BVzRNwO6orYLZOBm+2u4IpNhvDs0H+m+8ake6ZYVEMY=;
        b=HS9ZKd9/Q2TduXoldzBLyZRMSNRxoEMTbrzvhk0wza60Y0BVKBZyUQ1hdKOVv1I0ol
         85ICiA9liahZm5x0MPuPMnBmnigMSuBwwaywmPRZyKSA5Q9qjxsbsfzq4xy2ZMg1dKTT
         vei8CPa8huQKwUBtCu0+joltmFzVP7zf4xzORCds1TotqrWcyGC1iTf9LxS+49uVAxvf
         r4whrieicbqRTWLqgULF3qMUfbnxDJ5UoW3rbffftqL0G7yG/EMko26KjUAgPWlN36Sq
         SnPDSlCMaeFZZKalckfwPVboLB1SBs+VRwk5HIso8TqqgV2UWKh2vXr4CiQ6s5F6kW3O
         BDYg==
X-Gm-Message-State: AOJu0Yx1h1bS3wOPgfccJ8e7u+it6O33i64lwpGBuCxaBxDYBlfD5n58
	6OSuboj85pGkPxuLYzJk9V4=
X-Google-Smtp-Source: AGHT+IFvxic6V6Bi5/x/sQs+40jSupF9/hSHzsY67aFwTSbByfHr7PWOPIaPwSUQLZkwIOPnm52TrA==
X-Received: by 2002:a05:6830:e8d:b0:6db:ec80:9568 with SMTP id dp13-20020a0568300e8d00b006dbec809568mr1003615otb.4.1704391210282;
        Thu, 04 Jan 2024 10:00:10 -0800 (PST)
Received: from [172.16.49.130] (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.googlemail.com with ESMTPSA id j25-20020a9d7f19000000b006dc004816b6sm2826072otq.74.2024.01.04.10.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 10:00:09 -0800 (PST)
Message-ID: <d25434bc-f4b1-4c62-b4d6-ec53a8a5273d@gmail.com>
Date: Thu, 4 Jan 2024 12:00:09 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] auto-t: improve failure handling in testPSK-roam
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240103184638.533221-1-prestwoj@gmail.com>
 <20240103184638.533221-7-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240103184638.533221-7-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 1/3/24 12:46, James Prestwood wrote:
> This really needs to be done to many more autotests but since this
> one seems to have random failures ensure that all the tests still
> run if one fails. In addition add better cleanup for hwsim rules.
> ---
>   autotests/testPSK-roam/connection_test.py     | 25 +++++++++----------
>   autotests/testPSK-roam/failed_roam_test.py    |  3 +++
>   .../testPSK-roam/roam_ap_disconnect_test.py   | 11 +++++---
>   3 files changed, 22 insertions(+), 17 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

