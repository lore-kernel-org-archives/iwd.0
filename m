Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28C459168
	for <iwd@lists.linux.dev>; Fri, 19 Jul 2024 20:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721421729; cv=none; b=TxbBeppUFFvPM+5fUd44Xxs1X44x3XydGFr3gQIBwT9f/gRx2zVv7qJTy6J8jVCfoZKpgj3nnveYhRpqo0nnSPEaEhO63zaOElQmRsUs3khj5yGnXw1KtOGyLBQJ4Kbuq5eko2DWJB4x3uaSLQ1gma1Hv6g0dDNSiv5bt+8xtiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721421729; c=relaxed/simple;
	bh=5mC7HfoMFMDk2+PojraLD89LLwQDbB12S59HSGPkDrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Cv/4DV2F6e/eiblXOHo4rj7689e722n4J0oH9SJEsRPcqxrJi+4iLpyF/q7Lc2G4jiKH7stssHUgnBAsAog2rQhiBFyfPrmVMFK3g1/h0Oi0fEh4f42baioS/2s7VXvlgB9lfhfdKafO8oGkKOagS6TMgG69+4kkbxYIhUVB3O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFQc2BEj; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFQc2BEj"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-79f19f19059so106285685a.0
        for <iwd@lists.linux.dev>; Fri, 19 Jul 2024 13:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721421727; x=1722026527; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FpD6yd42xRb5dZTUzsKVGQiiHs+HfeWH09QXc9I3vgw=;
        b=aFQc2BEjdzcdt4+zbGI8+pdvmQ2c7Q362fA8orDhvIjtgTASagXymWxK16VA6gtJvF
         GtpkzJY1w1z0hALrkeY58TnGo8JN9Z+ocHkmwnoDvz1t8NR6G5ycukli8okL/Dcqvscz
         +CFPtQafVcstOZ+j/wCAMSDfzLH6+EdxaehQsIx7m/kF39n+HlgzL5bbHP6yILvi65xc
         q2WyrMiCtHdGDYxN3TCDe0Hhvw0GPzvO+sa4jTaR2DTusew/3nqYE1KF4SIzlzpgy6Uh
         1EhmhnxzEhONvfPMG/jfB9DmC/H+LtVSJcF8LlRN0vptqIwpvRKl2bDOJ+fH6GS7LuGu
         sBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721421727; x=1722026527;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FpD6yd42xRb5dZTUzsKVGQiiHs+HfeWH09QXc9I3vgw=;
        b=Qs/aSr1ldNQBcPpXe48xBKFbwcCA6UhIYejjO6rLapc2Dw4QHNUNcIe2hmZyzJYo3k
         XjSrpmczy6U5C3Tmudyk9j7ebxHfwBziJ+2+V6r2B48tfCM6srma3tcxt79SusonZhWV
         8EVLcfUIFlthFtvxWrN9POfK0rrEGZv3jvgzEFPQyDFsPIchH6NeDZem6HXvQ3UhMTrb
         3BXbfUHXzWvah34VBEL6xJVN3pCmjyvcQkouWh8rFSMgaSTSOWk/lGLAMonQ7xD9O/EN
         lM/yACdjcQ91ZoYMwzaIJm6oXQUfMpTbbCkEQK6cWCn7/plR7TelXsKe5lRPEVIsk/9W
         CG1w==
X-Forwarded-Encrypted: i=1; AJvYcCUKlGRg6tqJ2GAq2ODp1eIUbb722TIY3lWhuICd4BcxaoWesPLMG40P/D1NCXRL2AJlbCS1MTUtNpray1MODLV7LO1J
X-Gm-Message-State: AOJu0YxLJ1T+JUDkKDgQJzb5VmTv1oBqloPtkAfL3NIYyJR7jJOFwC6z
	pe6iLwQGI9AWFUfyREtLqlUpK5v+RlhD577skW6h3StvJLFowGvB
X-Google-Smtp-Source: AGHT+IFSg+sACK4Ba18N5SD5/3iCqJtwed43wCrGdd4AAD1fHcQaTIannDL+1ZOT0kPrJFnb0S0omg==
X-Received: by 2002:a05:620a:28c9:b0:7a1:41df:cca6 with SMTP id af79cd13be357-7a18745c54bmr1047096285a.23.1721421726637;
        Fri, 19 Jul 2024 13:42:06 -0700 (PDT)
Received: from [10.100.121.195] ([50.170.153.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a198fab28fsm128140485a.3.2024.07.19.13.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 13:42:06 -0700 (PDT)
Message-ID: <74956b29-14c9-47ae-ac7e-4294f52d2147@gmail.com>
Date: Fri, 19 Jul 2024 13:42:04 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dpp: relax requirement on IWD being in a disconnected
 state
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20240719181926.3888420-1-prestwoj@gmail.com>
 <abdda292-7c90-4705-9c81-9e11ffaedd10@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <abdda292-7c90-4705-9c81-9e11ffaedd10@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 7/19/24 1:33 PM, Denis Kenzior wrote:
> Hi James,
>
> On 7/19/24 1:19 PM, James Prestwood wrote:
>> Initially this made sense and for a completely unconfigured device
>> there is little to no downside to limiting IWD's state to
>> disconnected (or autoconnect states).
>>
>
> What about periodic scanning?
If a periodic scan was queued prior to DPP starting, then yeah it would 
run. But DPP queue's its next offchannel request prior to completing its 
current one, so once DPP starts nothing else can scan/connect until DPP 
is done.
>
>> Where this poses a problem is if the device has been configured
>> incorrectly, for example with an invalid PSK. IWD will continue to
>> try and connect to the network, blocking DPP from ever being
>> started and always returning busy. Even if you timed it perfectly
>> to start DP between connection attempts it would be canceled right
>> away when IWD tried connecting again.
>
> As in station_get_connected_network() returns non NULL?
Yep, since the connected network gets set before we're really "connected".
>
>>
>> Instead we can relax this requirement by allowing DPP to start even
>> if IWD is connecting, and only cancel DPP when IWD's state
>> transitions to connnected. Since DPP effectively blocks the wiphy
>> work queue once it is started it will prevent any further connection
>> attempts until it completes.
>
> But if iwd is connecting, station_get_connected_network() is true and 
> we've already sent the connection request?  So, you're inserting DPP 
> work which will run after the connection attempt fails?
Yes exactly, and if the connection succeeds DPP will be canceled by the 
existing logic.
>
> Have you looked into how WSC does this?
I hadn't, but looks like it waits for a disconnected state before 
starting? We could do this too in DPP I guess. Just check if station is 
in any pending connecting states (connecting/connecting_auto), set a 
flag, and start DPP when station signals its disconnected.
>
>> ---
>>   src/dpp.c | 48 +++++++++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 43 insertions(+), 5 deletions(-)
>
> FYI, CI is failing the DPP test for this set.
>
> Regards,
> -Denis
