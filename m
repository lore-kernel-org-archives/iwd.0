Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456227FD
	for <iwd@lists.linux.dev>; Tue, 27 Aug 2024 00:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724719233; cv=none; b=GAJoOp7F8sT3fp1jmphk0wX1ZPukThgUlZDhC38gzbgcXfZinN3ATaMBp2y7/8AycX8HMiH7mJMlarCA0pGKI7xN1EmQPLXzhQesCoQyUh9Ie4PoQN3S4UrzmHRUPGvPVG6esfo12c16Calt+FXCJ675xvZGOF2/TtbpsYQZU4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724719233; c=relaxed/simple;
	bh=uchWJSYBZ3DxmijxKwo64UHWin0Hz5G1SiekasY7wEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqKvPMoJsby/z0lIlSEzpA2lud3aOZXhb7omBN1ubiTlpmJ1SYtWG0C7007WW9sBoiy+EI0o/ds7c4wzaLgdq6qMdVKKiLIDdz62JTihZN2+uvLhrFOu5RGUo8Lt387ELBsoE6lOYPON7DnkTF/T4vghdB68PtcgJBZ6TXioAXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpUrWJfo; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpUrWJfo"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6bf784346b9so23378336d6.2
        for <iwd@lists.linux.dev>; Mon, 26 Aug 2024 17:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724719231; x=1725324031; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aZTSm49m8Fgftp4anI8WdhLULwCMv95a5OB5pBtiYRM=;
        b=bpUrWJfov7nnazj99sbpNq1sEiJnLLVk8O9AJB4eOS/zARpHiCSKHO7cdn9OKL3FVM
         TXFFujyr/K8/n12+Ml1QG/MrbQvRK0Eif0QgZWmFRJPn/4Kr7NkOB6mJzsUTZ0/dMX8Y
         4KKHY/TwqHx44ACPitn4BxT0ncNLUWeNnWjs0yrc9+UuJ5clhCjlsR8ovOfl+it2P3D3
         WZ3MwI3+CMg+ofG7eIclA1R0NCi+hsxIeQUf/H3tZomwPCunnmlxU8KS/WSGwOw8yiUS
         4P1PPkISKBZmxWRT9lUZigrXFJgpzwULsNTZ9n4WzEWouLv1DUOBRXrOSX7ATahApwSD
         KeYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724719231; x=1725324031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZTSm49m8Fgftp4anI8WdhLULwCMv95a5OB5pBtiYRM=;
        b=hWbCewTWUk4xCaNthI0DPK7aQkIxVstsKOkKLPcG0rIQ7xfUcF5dBWtL3Kg/RArf2A
         ZKlrxseep0zuECCm54UblRFWbl8AODgzuRfE2/sKgzNZtIeaDuohgnu0Hcde6cM+T81m
         I9IPEfYhDfO/F6EETXGcZCjLT7rd06mCPuZLtrUC+iqF2mvBt5+unkRpzNQQN+jwjUnp
         014k3PV+yu5Y55/vKiM4XgxQpg3eyjyQEXUwPG3o8hczghvkWMWMHdXiOdsJez8peCmp
         gqim/wmFH5r4iuI7FEb1OAYoi83lqgZxxLmyAh2iTIDqEbYU0ZYmxdkYQ+nzMDJnxYHK
         KgFQ==
X-Gm-Message-State: AOJu0YwsxW/Q43Fq3tWOw58mF0HFGxDRY/E6DgNI+IdJ0RvzshMweyVh
	XiClPNv04n17EqIHxvkNzCBwzxRY2jaA4cqWhH/raf8ey3iBN4PPkKonn5m7
X-Google-Smtp-Source: AGHT+IGzDC+m5qSjQSq8VN9e2hOvKMQE4BnVaZZzHlCdBkqgoxY/RQjb7iGJQWLgYmTlm9dkwjVa8g==
X-Received: by 2002:a05:6214:5d04:b0:6b2:9d0b:6148 with SMTP id 6a1803df08f44-6c32b90d3b2mr12287956d6.53.1724719230930;
        Mon, 26 Aug 2024 17:40:30 -0700 (PDT)
Received: from localhost ([2607:fea8:52a3:d200:324c:b818:b179:79b])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162db0964sm51040206d6.79.2024.08.26.17.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 17:40:30 -0700 (PDT)
Date: Mon, 26 Aug 2024 20:40:29 -0400
From: Richard Acayan <mailingradian@gmail.com>
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Subject: Re: Segmentation fault when taking device for a walk
Message-ID: <Zs0gfdfO_nKw_7PA@radian>
References: <Zr6cKJePuQd4Dm_n@radian>
 <5096b486-d2c1-4a7b-826a-d3e4af9e2eed@gmail.com>
 <ZsPATiu0_31D8Qcq@radian>
 <e6ff554e-ad17-46e3-b614-ac6da796b337@gmail.com>
 <ZsS9oqna82kDmgJy@radian>
 <290cafd7-b8ab-4a51-8f54-ba0b61a5afd4@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <290cafd7-b8ab-4a51-8f54-ba0b61a5afd4@gmail.com>

On Wed, Aug 21, 2024 at 07:27:41AM -0700, James Prestwood wrote:
> Could you try the attached patch. Assuming this fixes it you should also see
> some WARNING debug logs, which would be nice to provide to us as this will
> tell us where this timer is being overwritten.

Yeah, I see some:

	[Aug 24 16:51:10] daemon iwd: src/station.c:station_roam_failed() 5
	[Aug 24 16:51:10] daemon iwd: WARNING: src/station.c:station_roam_retry() condition !station->roam_trigger_timeout failed
	[Aug 24 16:52:54] daemon iwd: src/station.c:station_roam_failed() 5
	[Aug 24 16:52:54] daemon iwd: WARNING: src/station.c:station_roam_retry() condition !station->roam_trigger_timeout failed
	[Aug 24 16:53:09] daemon iwd: src/station.c:station_roam_failed() 5
	[Aug 24 16:53:09] daemon iwd: WARNING: src/station.c:station_roam_retry() condition !station->roam_trigger_timeout failed
	[Aug 24 16:53:22] daemon iwd: src/station.c:station_roam_failed() 5
	[Aug 24 16:53:22] daemon iwd: WARNING: src/station.c:station_roam_retry() condition !station->roam_trigger_timeout failed
	[Aug 24 16:53:32] daemon iwd: src/station.c:station_roam_failed() 5
	[Aug 24 16:53:32] daemon iwd: WARNING: src/station.c:station_roam_retry() condition !station->roam_trigger_timeout failed
	[Aug 24 16:54:33] daemon iwd: src/station.c:station_roam_failed() 5
	[Aug 24 16:54:33] daemon iwd: WARNING: src/station.c:station_roam_retry() condition !station->roam_trigger_timeout failed

> Also do you happen to know the wifi chipset in the Pixel 3a? I cant seem to
> find that anywhere online.

The Pixel 3a is based on the SDM670 SoC, and has the WCN3990 WiFi chip.
