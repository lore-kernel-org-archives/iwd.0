Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493F88F47
	for <iwd@lists.linux.dev>; Tue, 12 Mar 2024 03:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710212671; cv=none; b=HE66lzt6KzhUa2aswioU327Oo8G4K3bn3TlBturT5JCYgXoLTno80V3ZkxWiKR/Wray7Gp4fxkg8P9C8PtP5u7zL+gKIFZ/97O/ms8gr5X+ATqAF9gQDMJdEEmDntok5pI8l+bBYtwloNP3XXwl9tmP+0RtMniB9Ncd/3BDr4yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710212671; c=relaxed/simple;
	bh=grosVt8SoiunDZfzGR3Rla3B3VT278NGC4nKWqfmA0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=P6Wx7JLcfgrABPOlv1aERez8qpXmugv9jsC+4kc+pIBJOFGwnuaKKxGti25Cphs/w8IoJmyG1qLJacrlnFmwlGkf1iC3OM2r03agXFSgEIBDPVv322Az99s/giaC/2mBiI1Ou4n5ECTcAEkD64QsEGibFee3hAVbS0cP7HLdeYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgA7nkRa; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgA7nkRa"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-221ffba5c8bso849393fac.1
        for <iwd@lists.linux.dev>; Mon, 11 Mar 2024 20:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710212669; x=1710817469; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3SxZh7sFJKxp1hL4FhNZpykEsLgbDL5KTb/umkBoci8=;
        b=ZgA7nkRaCwgqDO7Vfj5Q6zrD4iKWT+5D5rYJvnivlzSYE8AqgvOWJ6IvxHAtoouoJW
         l0WhZJ9vJrOXfpbtapMk41xtcxVDsVck5rt/St68UpB0b+4ygQHIRC8holTvvGO9ylgk
         gIDEzgn26Gr7I/XEwTdE/3PYnvrX6Hm5SeIefLg2crPUqnNmx4MIPuRAafum25Owz0mW
         6p0yPzOP7getoOC8paJFSxk3c7/NdHIfUwhquZZratgXQUshcoxRXTQ9ViiWzNzyemvU
         vBU1IK10YpfsxG046teVs88vZMY+vm/0rmaJPx5FgmhPpX8xPbgVZxhZBjqWYeuTOOCL
         EPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710212669; x=1710817469;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3SxZh7sFJKxp1hL4FhNZpykEsLgbDL5KTb/umkBoci8=;
        b=n8w3TyzizKW8JxgqSLbGLpGOYw6sbiRVnUNE3rlD/uZ6Bs1EJqP7mVRluSXWe6SxjI
         JSnefBMvBEM4J9ViuFsR/WqG4ei9bP1TjGAJnZNYTjkCi39C/Dfss1xWfV3gLj9/LW9K
         Qq1Qm1Me4gIHQ6O8GrdEdcEvNW74gXuZ+Sl3+4S+9YKUAt8rIJDH4cuBxjcbYn3XHRNi
         CJ5ef2wcJC3GOAkmKk2wdgP+lDubbs6nzYE3VDMMjerg7rEelsw8+GyxxUScEXLC/WD5
         MzonS/X8mWemJb+0by3BeCJcVjykW3OkYCHFLM7LaKCTa7OTL4og202YSSXCGekwxhhk
         ikSw==
X-Forwarded-Encrypted: i=1; AJvYcCXddzma2leTr9OANd9Kj2wKdrOjMZRsBdYxo1R5sU4PKsdpf749TZiY//8uCioLpIoc9QO/hsdiN0sHeekc5taoyPAn
X-Gm-Message-State: AOJu0Ywe/dlLHbhUYCeBiYhVQGanEog4O22HYnJTbfCc4bF5A5NLIDHH
	bJQW2pxVEIS1xRYSuEL79GnNpiiRETjmI6fC/fj51Yc/apue0CrOKXmjsCG5
X-Google-Smtp-Source: AGHT+IGQvkZruSy4c9rqFpCek9arabIZHJ8kmydvzN1T5gbZ7Nfa/Xz8SwUShH9Ajge0WVj6w03HZQ==
X-Received: by 2002:a05:6871:14f:b0:21e:b98f:4501 with SMTP id z15-20020a056871014f00b0021eb98f4501mr9676258oab.22.1710212669252;
        Mon, 11 Mar 2024 20:04:29 -0700 (PDT)
Received: from [192.168.0.50] (ip174-73-27-232.no.no.cox.net. [174.73.27.232])
        by smtp.googlemail.com with ESMTPSA id fu6-20020a0568705d8600b0021f6a2bd4b9sm1939559oab.3.2024.03.11.20.04.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 20:04:28 -0700 (PDT)
Message-ID: <a1304439-f4e4-4593-b40b-e29faf33ea60@gmail.com>
Date: Mon, 11 Mar 2024 22:02:11 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Using bind mount for /var/lib/iwd results in zero directory (and
 no links) and no connections stored
Content-Language: en-US
To: Martin Petzold <martin.petzold@tavla.de>, iwd@lists.linux.dev
References: <07009e2a-3ad7-4a8c-bcbf-a665a19bd03f@tavla.de>
 <26f4ecf5-2f67-43f4-b197-9caea5ce9319@tavla.de>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <26f4ecf5-2f67-43f4-b197-9caea5ce9319@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Martin,

Please, no top posting.

On 3/11/24 10:25, Martin Petzold wrote:
> Maybe it is a bad idea to delete connection files while iwd is running? Or 
> should I do an iwd restart after deleting connection files?

iwd uses inotify to keep track of everything within the provisioning directory 
(/var/lib/iwd) and react to removal / modification / addition of profiles.  No 
restart should be needed, assuming your bind mounts support inotify properly.

> 
> Is there an iwctl command to drop / forget ALL existing connections?

Not today. You have to iterate over all known networks or rm *.* in 
/var/lib/iwd.  Patches are always welcome though.

Regards,
-Denis
