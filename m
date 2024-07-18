Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4667145B2D
	for <iwd@lists.linux.dev>; Thu, 18 Jul 2024 21:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721337087; cv=none; b=W8f5AGULjcx+taJLoIHYETEhkaDQIBmHMFNvMY6D9ZSAmQqCMINhtOFGtiFciy50DX5icjl+ZPzReiEYfYcKUDe6kIA6naP+uEfP6ffo7TO4UbJEycqTA+mdeHuH+oGEacTZ6WjD53E+1fSiXMVTZ7PPGUdSeu1fVmA//WcTs20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721337087; c=relaxed/simple;
	bh=MEN3eM4ayYIILqNgxQyodwNm3OsEyMgpZypKV+X0shg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oBflLB3LAClxMcTPNwTEGfHu4OBWaUTVb3vjgPr4d6AdcwisxBmEgFk1lup72bBgq5e8EFuwqrVq9EMY7X3tPIsKUXjX+WqRKvtAo+gqyWHAzCzDnSMVx/XUTMw4XZdhJyaQv8V51gjxzvF27AzDS1y6a0w9EwWwS6iTWeLwNi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWcnuZw6; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWcnuZw6"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c9cc681ee0so725143b6e.0
        for <iwd@lists.linux.dev>; Thu, 18 Jul 2024 14:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721337084; x=1721941884; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4WqlpYH9rOYK+lv+L8siNVMQFt+hxvbI04NJCNXS3/s=;
        b=FWcnuZw6Vg2FfXp+utXs4aQ2l687RuepFhe4oVgzlnMZJge6QGkRBha88i+Kp6dmkk
         qvZz5fEJTty3zgd0kaYGMhUfWbnhbRIZ1wArz4PRiRRFd87Aohs0niOTmAe1eh07OCAG
         GY/EDBQ2w6ZtxNrniM+zsUsRK72eHyMZ7gntAVgKfLyPN1zbDckAB2o/hlLqRlEoZik5
         KszIYr0J0fV/qYGLXbNBQyvXTJQAdlAKS8RCVTqG/C4KnYr64HSkU0ePrOt5wdKLbJUl
         MdI9RvBSsJyetLhKjSB9Xnti9IkHWSMA3ckzqb+56UeD1eobStcUXf+RrhMTjxUAWAbr
         43lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721337084; x=1721941884;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4WqlpYH9rOYK+lv+L8siNVMQFt+hxvbI04NJCNXS3/s=;
        b=EbIr5/hlLMekrcPh5d6p0O/qBGsGy8BlaPCFZ/4lZkhWdikLKDe4EMJ4Co5nHyIrcg
         LqvgwDKWqFg4eZheqw6agv2CjIh9ra9L9BDNhyAqBL7TmohZnMhxj8uiWWBg4Ruvc34P
         VlDvNurS9RMCOtyWnZsH3tR660+ocGo3laIK2z747mUJFWPo7PzDotTAVhCofboIiMVH
         7CilxMqCHFYc6khx+YRiFhK9Im7HRFsW2hALUn/KT8iY33HECWaOksi2XNjGztZGSJCZ
         ItTJ4yBJLipvRAqfo+F3ptbXAWEEUOc+0PnbWIixg0kC8J1fO+p0HP1hXoN2npsRpJkr
         ldww==
X-Forwarded-Encrypted: i=1; AJvYcCWUK8DR0/XOj6AHqqhgmFP2sHPb3dgwR0Jv9+KAcpEzp7Wwn0dzvnhcymZk7ZbhXdiZ0jy9cODVkIxXvh34iBpHGDA/
X-Gm-Message-State: AOJu0Yxv3EqvqSj58bT9HEz7wvzL0KRfyLdZP+jtIADp9foBEikjPPEI
	AGJjb7fkQGsEYvKYY+kLOnPLOGyLRbZi+ipQBTFwGbLSdybTLqwz
X-Google-Smtp-Source: AGHT+IG9frVkCHWWYPoN+A1QJ1JtKWt1FthQfuTDg15uaMnKWOhQVbOnpP+nJsg5G3O1mdOmdze9YQ==
X-Received: by 2002:a05:6808:2f0c:b0:3d9:20e9:52a7 with SMTP id 5614622812f47-3dad1fa2b50mr7572948b6e.54.1721337083662;
        Thu, 18 Jul 2024 14:11:23 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3dae096b105sm23322b6e.9.2024.07.18.14.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 14:11:23 -0700 (PDT)
Message-ID: <118788dd-a1bf-428a-9ac0-857741b531a9@gmail.com>
Date: Thu, 18 Jul 2024 16:11:22 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] Refactor to unify connect failure code path
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240718114514.2916258-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240718114514.2916258-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 7/18/24 6:45 AM, James Prestwood wrote:
> v2:
>   * Combined two earlier patch sets (autotests and netdev patch)
>   * Call netdev_disconnected() rather than handle the logic manually
>   * Add new NETDEV_RESULT_DISCONNECTED to cover any disconnect issued
>     by the AP during the connection stage. This cover the 4-way
>     handshake or key setting, or anything in between.
> 
> There are some additional unrelated patches, and more autotest fixes
> that were needed as a result of some prior changes
> 
> James Prestwood (11):
>    station: print unknown channel number in neighbor report
>    netdev: add NETDEV_RESULT_DISCONNECTED
>    station: handle NETDEV_RESULT_DISCONNECTED
>    station: update logic for handshake failure
>    netdev: handle disconnect event during a connection
>    eapol: move HANDSHAKE_STARTED_EVENT to eapol_start()
>    station: add handshake-started debug event
>    auto-t: add clear_events() to IWD class
>    auto-t: add reason/test arguments to hostapd deauthenticate
>    auto-t: Add deauth during the 4-way handshake test
>    auto-t: a few random autotest fixes
> 
>   autotests/testEncryptedProfiles/ssidCCMP.psk  |   3 +
>   .../disconnect_during_handshake_test.py       | 112 ++++++++++++++++++
>   autotests/testPSK-roam/failed_roam_test.py    |   3 +
>   autotests/testPSK-roam/ft-psk-ccmp-1.conf     |   2 +-
>   autotests/testPSK-roam/ft-psk-ccmp-2.conf     |   2 +-
>   autotests/testPSK-roam/ft-psk-ccmp-3.conf     |   2 +-
>   autotests/testPSK-roam/main.conf              |   3 +
>   .../testPSK-roam/roam_ap_disconnect_test.py   |  12 +-
>   autotests/util/hostapd.py                     |   6 +-
>   autotests/util/iwd.py                         |   6 +
>   src/eapol.c                                   |   4 +-
>   src/netdev.c                                  |  19 +--
>   src/netdev.h                                  |   2 +
>   src/p2p.c                                     |   1 +
>   src/station.c                                 |  39 ++++--
>   15 files changed, 184 insertions(+), 32 deletions(-)
>   create mode 100644 autotests/testPSK-roam/disconnect_during_handshake_test.py
> 

All applied, thanks.

Regards,
-Denis
