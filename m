Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBECD7FBC6
	for <iwd@lists.linux.dev>; Mon,  6 May 2024 13:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715003889; cv=none; b=lrPNKLC6uQ5ck2KenmNTPZjirtapWxCwrROPoHkWKp5oLLv4nTyvSImCl7rKIRKSa5JkYIdHzW+9HajvxikAuQrrJewN4qnlDCN4Jm2dKPcWIz3xGK2MVvH33Q4dF1xxDxfmStvJqV+1ylMnWckxHYrZNWEhcrQUy7ldR+1PSqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715003889; c=relaxed/simple;
	bh=j6ElZTCW5xYvR9bsVBUZeYV9ug32s5mgXST0SM5XO/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=StYE27u6AmqZrPcwr8vXG6k/TwjMQG3FzeEaGSLHkkOfko0Nf0LLxjZXifFYkHWDaizRVKDUoLnnuF9ZbVf2r+FWIX7fUxyocCmQNecirjoNmyI1FaVpTt6Lx2MZiCtsbraHfFU+ogAy5ipvSE/n1TMJaf+N6llTJyZdaw23SPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZq0R0wb; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZq0R0wb"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4df2d7dca64so392134e0c.2
        for <iwd@lists.linux.dev>; Mon, 06 May 2024 06:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715003886; x=1715608686; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q4nKnwQP6BUvl+MyCmr9l7s4d7Hx6KIkMuShIGEWwg8=;
        b=hZq0R0wbDYuSDIJYBklmTbhcppRu3n3m93+VFezmIvfFQwGsM+QtnbYGZitZ0cBkaw
         rYyX/MmFOrKp2V24Z3w9ibN+zmCpiz3fjpPZu4D3sZF7zTW7/MOt95r7QRSiBU4g878G
         29Croy2w7+AhbetThXFVUCZJ9g4wvGZtUh/JSahyscdqV5xOAj9q5YjShjXgk+UcL7kZ
         k7EGAlPrPQKPsfHjUuTQ+B1pdsq8ureA0xmSmTrfx2pO1nLxf1ZO+rDM5YN3SRlWQgv4
         rC/XSN8gP65/GnHnpR3X2yCv3JS3tFkGGc3GxOUvUzog2az2fBHHZSvRD/B5p+O/7b7P
         5gbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715003886; x=1715608686;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q4nKnwQP6BUvl+MyCmr9l7s4d7Hx6KIkMuShIGEWwg8=;
        b=PQ+5rD+XA4IQDJcluOzgpRWFx/EDLjkaz8vE8rNvtQMcTy0jEa/Z9LoBLzWJ4HECmV
         qmCqqkdYvH19oSTyxE6MOD1m41bDuMcMkb21F31i9QYD5QTY1PwtLCVOHXyrriSC9OKk
         qMA6SUicWyyLzj46keUiijB+KcdKJdspFEqciRWXY907rt+cMWWEFQO2QqSxmxWTL02C
         roE7YX3apLV/u5r6DuGEeUn3NlUjx3mq3krs1tbU8M6yrK+AY6kcInX7FUMqHY+/mCn6
         N87YT5Y4pB7KuxRb1Mi2PXhu7dU8Lc974qIa7xRXOjHKBvTXXo6rH1SEyxnmVycoDpvZ
         9GFA==
X-Forwarded-Encrypted: i=1; AJvYcCW0qcoyU65wJyleliMIPOyIeDsZ9R9cn04pKw5zfR9UjrNHkHZpzGwwkKPL7F6CPfTDerZKPQSKf1CXoyPcBkLPBcLY
X-Gm-Message-State: AOJu0YzdOON26RQAVcfWnYcv3UrShLCTiTwiScjuJvFDlNE3hO9bi4QH
	dSHToO8iQjRHIagUikDZzWsYTE+xdXgcPN+aZ+yZSjvdZ/jYGemY
X-Google-Smtp-Source: AGHT+IF0z71v9NFsERm02dw/Vb0RMNhHfOt4qHM1QtpSNEiIdOmjEkPZQA4lLyMQ4uhkY8xvF35T8A==
X-Received: by 2002:a05:6122:2091:b0:4d4:2fbc:e61f with SMTP id i17-20020a056122209100b004d42fbce61fmr9444987vkd.14.1715003886270;
        Mon, 06 May 2024 06:58:06 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id cp12-20020a056122430c00b004d41ded4a4asm1051048vkb.15.2024.05.06.06.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 06:58:05 -0700 (PDT)
Message-ID: <e49f9a7f-5d4c-453e-9dc8-1a7667383912@gmail.com>
Date: Mon, 6 May 2024 06:58:02 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Getting list of found networks
To: Michael John <MJohn@midmark.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <LV8PR08MB9350F79243154C9930EFC4BEAE1C2@LV8PR08MB9350.namprd08.prod.outlook.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <LV8PR08MB9350F79243154C9930EFC4BEAE1C2@LV8PR08MB9350.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael,

On 5/6/24 6:16 AM, Michael John wrote:
> Hi,
>
> I'm looking to better understand how the list of networks are collected  after a scan is done and get-networks is called.
> How long does a scan run for? I am assuming the scan causes the radio to go through each channel and listen for broadcast beacons to find available APs. I have noticed when calling scan and then get-networks I can get a different amount of found APs, like either I am not waiting long enough for a scan to complete or there is some other logic that dictates adding a network to the list (too low of an RSSI?). I'm also wondering how much of this is really controlled by IWD verses the radio firmware and are these simply request sent via nl80211?

For a DBus initiated scan IWD is going to scan the entire spectrum, 
2.4GHz, 5GHz, and 6GHz (obviously depending on hardware support). The 
scan runs for as long as it takes to scan these bands, and that is 
hardware dependent but generally takes 100ms per channel/frequency. IWD 
has some logic to update the networks it finds throughout the scan, so 
if you call get-networks too soon you may not see ALL networks that the 
scan finds by the end (there is a scanning property that gets set 
true/false to know when the FULL scan is done). Its very normal to not 
see the exact same scan results per scan. If some AP has a very low RSSI 
it may or may not show up from scan to scan.

And yes, all requests are sent via nl80211.

Thanks,

James


>
> Thanks
> Michael John
> CONFIDENTIALITY NOTICE: This message, including any attachments, contains confidential information intended for a specific individual and purpose. If you are not the intended recipient, you should delete this message and any disclosure, copying, or distribution of this message, or the taking of any action based on it, by you is strictly prohibited.
>
