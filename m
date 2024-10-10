Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B5315CD49
	for <iwd@lists.linux.dev>; Thu, 10 Oct 2024 15:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728574350; cv=none; b=o/TRyQ6bf9l1Gj5pL/x23tR6bYZ2/lBTFwAMSwY6NjkgKpglPFf67BHqcsJxgaQ3+6eULVzzIDq015x9eI+cCEjQpyZheCrt5T1fb+mJwzuVJ5LuaxkuAHMU2dNcXKCDwBaJEjXmILOFX9g+6EDhLPnTDP74wAVZTV+gPKl7K0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728574350; c=relaxed/simple;
	bh=GDw2WlbvcRiqiB/XYM8fr5J0sKQZDc2kKQM3c8nUHc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gO/9fNVP4vz3dsHW5cx318ND+1FgRetYoKfoc2F9g0n1dvBXrV4G6Cqoelkw40g14DV1p3H0uGMiJ2qmvrmm6a4+QYq6AZzIzzbqP81tgvmHVxjyEZX0Q4vfEDLaB+m9xreb8LE/l5nt35xs3+0z7L1x+ArRkDObKxuEZMsuHaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUfDsJ33; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUfDsJ33"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-716a6e6d5a3so710706a34.2
        for <iwd@lists.linux.dev>; Thu, 10 Oct 2024 08:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728574346; x=1729179146; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GDw2WlbvcRiqiB/XYM8fr5J0sKQZDc2kKQM3c8nUHc4=;
        b=gUfDsJ33/oT4t+hqjm0L7MXpy4jAgF6u/Y8A3BYc7THyDDdT2oB/IWFcaWwMk+wDUN
         zKx78GtiXMUujEPrwbNhykBeJk5WYoby2NA3/KIRP1JCfAzS12KaW3H+pyd9iLw13B4e
         UaUSwePvTHYy6CPrJXW33Tf6aSuGm7t6ofxFHpXqiZLdmUyfRGpNzgwJlYy1oyhToHY1
         Ln+E3EcGbJniJrOiKWDFcCpNxoqKFdHEZPwh5h9dnDGKWEoZqco5IM3fHCUO4ZScna8x
         iVYEFqpy0EIOzYVDwVd1XxSrtCLMTBS0a/O4XqA7h5pMg6QFB8B+cFk7RpCFm6ybtxpT
         QqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728574346; x=1729179146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GDw2WlbvcRiqiB/XYM8fr5J0sKQZDc2kKQM3c8nUHc4=;
        b=jsVwNrp+dvtu8429lAtxYIi9PGdPcClDoSGvlfrkuMf+l+8nGu65b0YimEA0elBT/J
         qQOZ8583dpev+OCNgCjiG3I22AGzTiszBmXibcIMkZZ8vXmDcYQMD5bA6cPl2RqE3APV
         2RXS1soItqLgYkfM0x9ISo53ULEU4R8BWoO7k3Algdi8orbftf/b3WiO8KG6+tdCzKtd
         zoqJJVnt7EaA3msOnEHoNfCwLzbM3kQNNxZPndBydIdY5RGui9IGZ7Bk/GCJkP6wAk+5
         bq9+xmNJsg8wr+vkc8BjeeJ6p8cKDQTD78CAWWuHpjMvAEv8Jc7Df5rSBMnW08EO1ryg
         LtPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdSC05vDG2xpMFo5ojYE84zGo//9Hdj1fVBrDTpgFqInBxlDzwzAvm7HKdiquY0oolWZM=@lists.linux.dev
X-Gm-Message-State: AOJu0YzQuxjwVUeeeuVV7PrMmp8Yy5Hw/ERDbw8AwHgvMkcapXWfX/ok
	TlYak5ByTHOJqQ9JeUUe/z6etuc5tr/tV8/goivZORp5cPDcvoWI3RpqTQ==
X-Google-Smtp-Source: AGHT+IEvIqIJDl8fZrwffXfowKqwYPyYJekHCDgJwzS2QPjX93E3DPzV8M6X3ferWqDJ7IhmbjkNOw==
X-Received: by 2002:a05:6830:2b21:b0:715:3f20:bd2c with SMTP id 46e09a7af769-716a41b1416mr6192962a34.10.1728574346502;
        Thu, 10 Oct 2024 08:32:26 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-717cfed76besm215277a34.11.2024.10.10.08.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 08:32:26 -0700 (PDT)
Message-ID: <3e269342-17fa-4ef8-ab5b-6597ee244284@gmail.com>
Date: Thu, 10 Oct 2024 10:32:25 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: AW: IWD 2.20 does not support Fast Roaming with NXP 88W9098
 chipset
To: Dierk.Modrow@sew-eurodrive.de, prestwoj@gmail.com, iwd@lists.linux.dev
References: <5c65040719764a49a48846ea11c535a7@sew-eurodrive.de>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <5c65040719764a49a48846ea11c535a7@sew-eurodrive.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dierk,

> we tried to implement 802.11r roaming with IWD 2.20 using a NXP 88W9098 chipset from H&D Wireless as client (using out of kernel tree driver of NXP moal/mlan -> FULLMAC) and failed.

Is the code for this out of tree driver available somewhere?

Regards,
-Denis
