Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510AC19D075
	for <iwd@lists.linux.dev>; Tue, 27 Aug 2024 11:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724759218; cv=none; b=RkL9MJyX2xjWPh7edhj0xfGoVI9XgkhObwKVxEaaYqPt8Ly7V+600pCMPBv3P3M9W5L6c8d8ygOEHcL6WLAvdds6Z/Iawt1wJoaVVoHj0eNO3u6jVFITS6ugC9FzAm34eaoXuXX+GtjEPaUE2GlOUc2ma3tV4wwBr0Q+qDqRAi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724759218; c=relaxed/simple;
	bh=PmC7hYveeLz/Y+SooWSSdyJ+2or/BfBc6Vqtm3gxk6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pv2FWVUUB2GldJsx1A/y1f4VvxQb09KdzYB6VF6XXdFNGbkESj6nkOhmfyqzTfHFkO4JB9NirlGG7K5eHNqENJzCXBa/b0IRtL3qU4HM9elbJqoEcxKYulhr+g0XsgjpSfM7gA5uhDtQostJC92JDyBdBIBAeZ9gCogd1YsNQsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLpm7ffo; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLpm7ffo"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3db1e4219f8so309542b6e.3
        for <iwd@lists.linux.dev>; Tue, 27 Aug 2024 04:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724759216; x=1725364016; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C/36cE2yjlYoW5gLsUqy5eZ+h5JQViopzt4ET5xtNJo=;
        b=gLpm7ffoSjiv69lJbHXHnsyVOzBY9drQQVWby6ZE7wkB5DNFhPHGs4jO7ZX9Ela2VN
         zaS5xga54qu3Gy+ZiBDVmWnqUUO4j6Mgls6ZkLlTJoD5bSTKrdAaYuH+NPNTdq82mTW5
         XfA9laEqYGfiXo6b1jKf/tp2bg0q7+X5xXGrKDitd3wtOKSdjwDsy7kRtHFhOxDBOcCZ
         4ATC3RSuAVVQCl9r7F6bERoX8k7FnySvbA2FalweS4JErV8YU+s7sVn4AH3ZbOlYcgC8
         zg8lSS1hQGRAe2V9VR1YOFjr9tALgb2qG4k1Uobz+pPlkMiUbUtEqrSEX76cUJnGHVf+
         CkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724759216; x=1725364016;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C/36cE2yjlYoW5gLsUqy5eZ+h5JQViopzt4ET5xtNJo=;
        b=ICZBStgOfxX4A7HsbxhncaU3N9ySpnCzKN1Drw9lityr7eAVipIve4x+x3M3LVNXy/
         5YjSqRjJ9UFjn7BFYZELI4ypuIjuBwbLT+TVhmfXuMnNdxhLTHtghu9fQ4nW0Tqsoqx9
         siZVHRGN+vUW8TppnO5vNmNL5cfBUfrTTTEg3sCCx9znUQ0sZRwgfeEMnfGks5hlivnL
         qcOXv7bm45qp1rZRmF6VJ3h/E7w7VkeR69uocsagEhLlCw0roNbeiykVn8Zp+2r2bxI7
         lhTQaCoyljHK8GMVM1gQML7f0XpsDFx9/bPM0n5N8y/n4v4LjT78512fL4KbzdMnCkkE
         BdKg==
X-Gm-Message-State: AOJu0YwGeOqBwyvcYLVbpU5iXczWc01AC0wcw/soHQBG4n5s09eMiTHl
	AzOQUygF08hnzl3Y+P9Qc34fI9JEq1efcVulk/+GAb2so/o1nYEJ
X-Google-Smtp-Source: AGHT+IGJZmCblTPRvL2WlRxJ+7VMm+mYRbQ8PxRp75V07VA0abYRfqU4YwAWDmRyqYuzAo6iUHLvbw==
X-Received: by 2002:a05:6870:9708:b0:261:16da:deca with SMTP id 586e51a60fabf-273e6592cc6mr14380928fac.27.1724759216193;
        Tue, 27 Aug 2024 04:46:56 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342540a7sm8390436b3a.83.2024.08.27.04.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 04:46:55 -0700 (PDT)
Message-ID: <09b73faa-c5b1-4fbb-8925-0dc5edd04713@gmail.com>
Date: Tue, 27 Aug 2024 04:46:53 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Segmentation fault when taking device for a walk
To: Richard Acayan <mailingradian@gmail.com>
Cc: iwd@lists.linux.dev
References: <Zr6cKJePuQd4Dm_n@radian>
 <5096b486-d2c1-4a7b-826a-d3e4af9e2eed@gmail.com> <ZsPATiu0_31D8Qcq@radian>
 <e6ff554e-ad17-46e3-b614-ac6da796b337@gmail.com> <ZsS9oqna82kDmgJy@radian>
 <290cafd7-b8ab-4a51-8f54-ba0b61a5afd4@gmail.com> <Zs0gfdfO_nKw_7PA@radian>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <Zs0gfdfO_nKw_7PA@radian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Richard,

On 8/26/24 5:40 PM, Richard Acayan wrote:
> On Wed, Aug 21, 2024 at 07:27:41AM -0700, James Prestwood wrote:
>> Could you try the attached patch. Assuming this fixes it you should also see
>> some WARNING debug logs, which would be nice to provide to us as this will
>> tell us where this timer is being overwritten.
> Yeah, I see some:
>
> 	[Aug 24 16:51:10] daemon iwd: src/station.c:station_roam_failed() 5
> 	[Aug 24 16:51:10] daemon iwd: WARNING: src/station.c:station_roam_retry() condition !station->roam_trigger_timeout failed
> 	[Aug 24 16:52:54] daemon iwd: src/station.c:station_roam_failed() 5
> 	[Aug 24 16:52:54] daemon iwd: WARNING: src/station.c:station_roam_retry() condition !station->roam_trigger_timeout failed
> 	[Aug 24 16:53:09] daemon iwd: src/station.c:station_roam_failed() 5
> 	[Aug 24 16:53:09] daemon iwd: WARNING: src/station.c:station_roam_retry() condition !station->roam_trigger_timeout failed
> 	[Aug 24 16:53:22] daemon iwd: src/station.c:station_roam_failed() 5
> 	[Aug 24 16:53:22] daemon iwd: WARNING: src/station.c:station_roam_retry() condition !station->roam_trigger_timeout failed
> 	[Aug 24 16:53:32] daemon iwd: src/station.c:station_roam_failed() 5
> 	[Aug 24 16:53:32] daemon iwd: WARNING: src/station.c:station_roam_retry() condition !station->roam_trigger_timeout failed
> 	[Aug 24 16:54:33] daemon iwd: src/station.c:station_roam_failed() 5
> 	[Aug 24 16:54:33] daemon iwd: WARNING: src/station.c:station_roam_retry() condition !station->roam_trigger_timeout failed
Are there any other messages in there in between those warnings and 
failed roam prints?
>
>> Also do you happen to know the wifi chipset in the Pixel 3a? I cant seem to
>> find that anywhere online.
> The Pixel 3a is based on the SDM670 SoC, and has the WCN3990 WiFi chip.
