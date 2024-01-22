Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9990C46443
	for <iwd@lists.linux.dev>; Mon, 22 Jan 2024 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935710; cv=none; b=SbHfPQx4/ztvdpDuWyUErJe3E99ezyMW+z+ZOer3k7aNMBJFUzgvKEXF98kttmlTc5vmy3gDGrpIYkDpYFyXismd6XqTAEUhXyBbX7Oy/mFeDTUFo41phuKECpOt9Jcserk1BiGyDGerto0EnfzkthOTTI0Ub3Rgm0t7CNQ7GZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935710; c=relaxed/simple;
	bh=t7JwQce5MD0vMfmJ+fze8nBxiTAORlCY80AvJ8umyJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oGUpz84WBJ7eon/YzSmBFVE9RdGCK4Nvt2qF+KTO70qIVIOIzO62Gv6Mm3O0ILQJvtYXWh8PbR2yb+BQbsGEGAtWXtSDxtKtJ3bFfmCGJrb9yR3IbL8HObYxRFWA3hO6plg9meq2N7P1+yR7jkG7dVh4WIfz//5e84JTGen9UW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCyrtoFD; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCyrtoFD"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6ddf388ca74so1646684a34.0
        for <iwd@lists.linux.dev>; Mon, 22 Jan 2024 07:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705935708; x=1706540508; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BcsT7Hm7eVsg1asJjffpSCI4HASMHSe4zH4r/fpkybU=;
        b=MCyrtoFDdNNl4KyAZHrIpaQf1jwx1vcCbaNImzZq0sh+ZpC5rXB0+Qvtk+hf3UgzI8
         csuG80Cf/2E5F9pa4lLk9vPoNx0ZIzDdZ1vfvcdv2JG+Jx20m4Z0IrH7h+XqjBjz83/Y
         Oyi3QNaAvjVH6oj1bu/ReEIhkcqOLtNMOhuaXIzVV8zFDgFOQNdsCcMGH1uVDvNpTL3u
         u1BvEcxPtaHtRtJkepzuqLvv4erupA+iBuv45m98YTbkmQ60o+sZcgDn+TU899N8Vmyd
         QjMH2ohFwb/ILl7yYk7JlD1Cr6kSbPij/7csn+QAMb2Xqt6NvKwkzuRrxQDxWresZRLn
         g03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705935708; x=1706540508;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BcsT7Hm7eVsg1asJjffpSCI4HASMHSe4zH4r/fpkybU=;
        b=TTtumXD6kfsDfcJ3NnADDb82qrQvmLh+3dRGjCcnLcCjLYP0Jt31OG0YavkFWKhckz
         E9clea4L7V1o7TPLg/fv19jufppPDwfl3IF3qaqJhQ0+/4YenvMHVldJ6zk5juNuG8vN
         vvzzHegXeiLdHqOHIIp9kxAg7w5H3l/wU5rjsiAhmXjS1nIB2jCvYNGf3XG/hqXqkU9t
         ub9Z8BYZXElyFSqNawM9cy+q9wBJ+hLcIg39THiPpvhwKqfsZeQ8cAiTIvQGx9q4c2lV
         gOqOHC8PobYAPaAJJXefESbGWXfmgR4iqCLmctzs9w5RVODkdwBVvJfMEZdcLe3jxz9F
         /05Q==
X-Gm-Message-State: AOJu0YzHWpV7CHLV9CMLiGRMX8H17A8AxnII/GJ7dbh9/9IBx5y0kK5O
	8/qwvSnpSFmZUgdHRnHHN8m6vGJ7RpO3xQU/0+eolvTCb/SHHrb9
X-Google-Smtp-Source: AGHT+IHeXvVRBQ6+rdR+o1q2/PIylbK+2fS0jg5qU9TjigG5jS0hpbQumpkrR3eVkBw4MNz3YagCBA==
X-Received: by 2002:a05:6830:1d63:b0:6dc:65b7:2b05 with SMTP id l3-20020a0568301d6300b006dc65b72b05mr3578887oti.47.1705935708495;
        Mon, 22 Jan 2024 07:01:48 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id bt14-20020a05683039ce00b006ddbfc37c87sm1712232otb.49.2024.01.22.07.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 07:01:48 -0800 (PST)
Message-ID: <3aaec29e-7b05-4a2f-b92b-40fbdffa860e@gmail.com>
Date: Mon, 22 Jan 2024 09:01:46 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Making udhcpc get a new lease when iwd connects to a network
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>,
 =?UTF-8?Q?Rafael_=C3=81vila_de_Esp=C3=ADndola?= <rafael@espindo.la>,
 iwd@lists.linux.dev
References: <87h6j670ye.fsf@espindo.la>
 <e1a35af8-0c7c-450b-9d96-fa8987e4c0d4@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <e1a35af8-0c7c-450b-9d96-fa8987e4c0d4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James, Rafael,

> 
> I think the intended way is for the DHCP daemon to listen for the interface to 
> set carrier up (from RTNL). This is how systemd-networkd does it, and AFAIK 

Refer to https://docs.kernel.org/networking/operstates.html for an explanation 
of how this is supposed to work.  The kernel will signal NO_CARRIER any time the 
wlan interface is not associated and IF_UP once the interface is fully connected.

Regards,
-Denis

