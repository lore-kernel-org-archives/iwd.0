Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D08C29A2
	for <iwd@lists.linux.dev>; Tue, 30 Jul 2024 15:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722354825; cv=none; b=AaVB7+/7p0bHA1t2qpk6sFI1IRhx/Bb7hdsqoEWX784z0i4Iy+dsmGyKrf4k9ZW2tVICz0HdvLpgRvZPpnxC9m4AcC42Rn94qFcHdmNDgjg4/4JgFZhTgFgU6M0SdL5M0nz0+vgR+QhAyBHxtiC5K5pf+MLxYJkHjH6I0VL1+FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722354825; c=relaxed/simple;
	bh=O3iY0o+B69E4qIGyHyOE7MqPnlS9Rt1ZpXmX4vq/JSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZCr1c4fAMURm8+eAIUKe/9s/0ZBRF3wRWhx6b5cR37uSx6C3/VrFDmmYT4pq/4/aYGuuY+RSO3f8TrifRS8ofxc3uVYR6ZovE13ik6ilt1FPWr+ZVE9SDqwmY6D6US+wABjDJuluPslUk53afHHCLJW58eVtAHHLSgo6gUlDZpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyT9etSq; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyT9etSq"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3db157d3bb9so2546811b6e.2
        for <iwd@lists.linux.dev>; Tue, 30 Jul 2024 08:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722354823; x=1722959623; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pcSnCLI6IccymH/8wKQKr01/QFjpCYtaE2vhBrT4Bls=;
        b=FyT9etSqfaBRqpqTeYHJhYYppKYpNopiJp2i6KY1IGoz35CmCFDT1d8s48dkVfgURw
         cRprHA4avEqX/+weqGxQvxf8cuT40GCunl7gvg1lLE2loSYnqIFglAEdc5rc4gjrt0dz
         vd0y/xTu5nB6uIs3dNR4VNRgQyjvdC4HuWkMLYdcnpjNchyID5azeizdBZFYrr1UTERg
         od5Wd5LKhjDjKHWEXb86q2IvK8PGbn+LUQ4rPhiLgpnaxWlQpAOVvEGBZjEnqRE/IwHo
         3oo0SCkIubwpp92+QdDXiXpqgCwlMvm1wEULnvQPXv77CYKjgNP1S7a1QHT7ohuHssvH
         +bEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722354823; x=1722959623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pcSnCLI6IccymH/8wKQKr01/QFjpCYtaE2vhBrT4Bls=;
        b=G9zjp5Fk6E6t5q/Kg8gL/xbl91tfqFzOe57V7Lcw6BnpyylZmFIXmklJtulsV9Cszz
         vqoY1GnGHCqlc2jAvon1Q9PGAeQ5CL92GK93Xgwk9VlTjSNM3FxZT42sFPwEBbIpVtpJ
         dzx3oOweVRhtlgq4Z4fNzMp62r63q4UI5xmPEYswYXcdfUiob82y6M38auJAE9oYajey
         Y2P2oH87ojU8fggaMy5T4Rz99ipqyjRb8molIQVMnVhH/c3CstS8k4owcSGVvTO/Xg6f
         BrRtKijmVngO3PLBzpksUowH8eNP+4/wSbIFaVngkCbbFbAJRwPez8/EFwiuhA0lJJWR
         B3Ig==
X-Gm-Message-State: AOJu0Yz4C5NSDqTJI0aNu2zw0cAguHzNHvIcjAU5rEZYobWfZlvhlxpX
	Lvyq6OKjtvP+9boUW8X9gtv5QpNWjtHYM22UNnVlwNh2fc+VixzZxqQWAQ==
X-Google-Smtp-Source: AGHT+IGh2DNFdX4DuDbiYhShEoiMrHkfq7IYrpflDXzit8LhLekzA0cSGP/1ozwN8wQZrA5viRwD9w==
X-Received: by 2002:a05:6808:21aa:b0:3da:aac7:43b2 with SMTP id 5614622812f47-3db413c82c8mr3309801b6e.34.1722354823379;
        Tue, 30 Jul 2024 08:53:43 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3db41805faesm326811b6e.30.2024.07.30.08.53.42
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 08:53:43 -0700 (PDT)
Message-ID: <6f21f4b5-eaf1-4a45-a53d-2656e50b3474@gmail.com>
Date: Tue, 30 Jul 2024 10:53:38 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] monitor: Use genl APIs instead of open coding
To: iwd@lists.linux.dev
References: <20240726150846.146628-1-denkenz@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240726150846.146628-1-denkenz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/26/24 10:08 AM, Denis Kenzior wrote:
> l_genl class has nice ways of discovering and requesting families.  The
> genl functionality has been added after the iwmon skeleton was created,
> but it is now time to migrate to using these APIs.
> ---
>   monitor/main.c | 93 ++++++--------------------------------------------
>   1 file changed, 11 insertions(+), 82 deletions(-)
> 

All applied

