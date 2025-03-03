Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E1120F09D
	for <iwd@lists.linux.dev>; Mon,  3 Mar 2025 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741011216; cv=none; b=gUb4CdCXcDcHDj4ivKoiWGaFM++FLJLrX3Nf9OUTSAWFUrancB1NJa9NauiGsyLdjAQe+9qvef99U5C6FYlwhT4XNFs4C2tc+1nIBYlWoEaFRuSO5jJo9563gLPDM9tidDOUDD8Fq4nyOK2j0Ru0O4aHqTHQ5jmdaDRouCpxUM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741011216; c=relaxed/simple;
	bh=ywmHngoqATk3nvnu0mbTEAwUqyaNaHr1qU5oRB1Egho=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Y5R06xRtnH1Tg0ffZEr6rc8hg8c3aeM1+MsVo5RELlpge1PABxSMLE/zGc936AeSdulUkI9eM6hpeNMWCucojJXrbHajHd7TkbOpwllJNw3jI55yiHcFGT/Lf/lLrhvsLgXWSpzGgbfVFplGKyXVU05BkB4gmPzK0UhNzYTGRf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IO7ZAjxn; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IO7ZAjxn"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2238d965199so26816005ad.2
        for <iwd@lists.linux.dev>; Mon, 03 Mar 2025 06:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741011214; x=1741616014; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jkg7/DzEk1vtzShMrxXdfGU59Y9/gs9EuUixrDl2wiE=;
        b=IO7ZAjxnb6C1MX1LjK+5FN3HZn39Pt9srAhnOhjYUVEg6jDptNnmPXebh3HrD+Cqgx
         Cn9ydKs11rKnLJHasy7MbjG8u0rckcfRzKBvmWwzoywn3gFC7IfdlLjIOGumuHAN5Knb
         cpJGZWoT9A83aQKDAFxzZciZin+ziZ2tQQesN05gjT9gglNP5h9z+cmFln9Sr/NB2IzU
         3u3mTkvjvQfZ3vx+Dh8GejyY4KtTCLnxVxMSK87589hkpteAVMhYYxAn/QFzmIH3rO7G
         xN+lUeNj/6YF7baw8LspbM24X0hdnqqq+UtKU30GrIcOcxPg3FZYIEDmJoK6u8RrK1HW
         PRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741011214; x=1741616014;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jkg7/DzEk1vtzShMrxXdfGU59Y9/gs9EuUixrDl2wiE=;
        b=DT4zVMbWNPI7D6Ilit9oORlpdPhmjsh/qrCGHh8x8dXn+n6AwoRg4dn6zQySFfXypd
         F6YIxhO/LfHXocuXw0pMhT/PpZZ2pIT8WnyGCRbaO4sbyyOsLIrkwDttXqw4k0FLBQvd
         5JuJ29JStWtkX+pNuggjvJy9X35eQDPksZRQEiv7C/U9iPCO/xZShC3k822U5RlYr1yU
         3Kph/hCE7QnwelQBh8YVRQdBEb8Zh0YpauEilikeTpyCctCcnsZfD9NjR5q6FP9Lawnp
         7WlXVaKXkp6ZmTY+Hvjd7QBV8Bi0ERAO2ijsFaC9s8+kWDBh5ZYpvHau63tb2NiCDtVu
         9PbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU69No6rXdng9wAZy4BVUUg1k2kJ5pUmhJbQFYqbsvLKmSceb+LWpk1u6ljO09ihez458U=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywr0QyLbwPnZaId6CllvNM7+JIUG2EpXX5A+1fQHIoVCSHycoAm
	KNfi7o3DIpJyGvJNa74ttPK5k7kO9QlD1QirBEq1VRrD75yAntMXDRKXoA==
X-Gm-Gg: ASbGncs8T3Lxayprwa9a0pYvmUSYWF+rwctNrqlZEcuQR1BdbI3/qIFbzlpDUhhHk43
	M8M4PRALyrLPaqkFI8NSvAvBYaYc0yyvPquoRag7ZRitKPRnw1yOiScUT+CQX6up2ri5vocGbUT
	l6afJ8BkZa7IfoWhon/5xP2XquauyFTF/FT2sIZoS/L0py69Kc2AjXxBoKmziWnwNTHGQTLWucK
	FrejX2wjRlNI+gITaStPQgchgCxl3kM+3aVgoxQOfZo24xz+YFhqtPuPaybxluAAgYmPGaJBl1y
	wxYRdoy0NSB2rMT8zJj3xas+PiTY7XRXTYkDF+z0cgXuIrEy
X-Google-Smtp-Source: AGHT+IHp+CbOAu1KEKNgACpnVepElpmK4ETIVo6cbZoqI7cHzacflhWcFxhrWbFyeuzM0c8vQPOUNw==
X-Received: by 2002:a17:903:198e:b0:21f:988d:5758 with SMTP id d9443c01a7336-2236924e748mr206216555ad.35.1741011214034;
        Mon, 03 Mar 2025 06:13:34 -0800 (PST)
Received: from [10.100.120.127] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223505359b8sm77948845ad.253.2025.03.03.06.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 06:13:33 -0800 (PST)
Message-ID: <4bcf41da-6b34-49b6-943c-873d3716da3f@gmail.com>
Date: Mon, 3 Mar 2025 06:13:30 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Suddenly, no DHCP
To: KeithG <ys3al35l@gmail.com>, iwd@lists.linux.dev
References: <CAG17S_Pxv86uZ9hQe_upS8ybu6KDpXxhUYDa-q=R6muWSYXu+g@mail.gmail.com>
 <CAG17S_NWzR7DtwVYPRFRkLHzfp1mAnK5_yC_pgNHaA79fVASRg@mail.gmail.com>
 <CAG17S_P+E9o-_OZQ2s4NewFWtf8qx+DrFPvOM6Cbtz4Yed_A0A@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAG17S_P+E9o-_OZQ2s4NewFWtf8qx+DrFPvOM6Cbtz4Yed_A0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Keith,

On 3/3/25 5:02 AM, KeithG wrote:
> On Sat, Mar 1, 2025 at 10:32 PM KeithG <ys3al35l@gmail.com> wrote:
>> On Sat, Mar 1, 2025 at 10:47 AM KeithG <ys3al35l@gmail.com> wrote:
>>> Group,
>>>
>>> I am flummoxed. I have an image that I had been using to connect to a
>>> WPA2 SSID and it has been working for a very long time. It suddenly
>>> quit connecting. This is an Rpi Zero2w with the brcmfmac 43430 chip. I
>>> am running bookworm with kernel 6.6.77. When I set iwd to debug, I get
>>> this:
<snip>
>>> < Request: Connect (0x2e) len 176 [ack]                               18.194060
>>>      Interface Index: 3 (0x00000003)
>>>      Wiphy Frequency: 2422 (0x00000976)
>>>      MAC Address BC:2E:48:FD:9E:70
>>>      SSID: len 4
>>>          73 70 67 35                                      spg5
>>>      Auth Type: 0 (0x00000000)
>>>      PMK: 254 len 32
>>>          e3 d8 60 09 bb db 40 a5 ea 9c 81 1a 96 87 32 f9  ..`...@.......2.
>>>          2b f9 9c 4e 91 96 76 4c 55 5b 06 0a 14 5e a3 ca  +..N..vLU[...^..
>>>      Privacy: true
>>>      Socket Owns Interface/Connection: true
>>>      Cipher Suites Pairwise:
>>>          CCMP (00:0f:ac) suite  04
>>>      Cipher Suite Group: CCMP (00:0f:ac) suite  04
>>>      Use MFP: 1 (0x00000001)
>>>      AKM Suites:
>>>          PSK; RSNA PSK (00:0f:ac) suite  02
>>>      WPA Versions: 2 (0x00000002)
>>>      Control Port: true
>>>      Information Elements: len 38
>>>          RSN:
>>>              Group Data Cipher Suite: len 4
>>>                  CCMP (00:0f:ac) suite  04
>>>              Pairwise Cipher Suite: len 4
>>>                  CCMP (00:0f:ac) suite  04
>>>              AKM Suite: len 4
>>>                  PSK; RSNA PSK (00:0f:ac) suite  02
>>>              RSN capabilities: bits  2 - 3: 1 replay counter per PTKSA
>>>              RSN capabilities: bits  4 - 5: 1 replay counter per GTKSA
>>>              RSN capabilities: bit  7: Management Frame Protection Capable
>>>              01 00 00 0f ac 04 01 00 00 0f ac 04 01 00 00 0f  ................
>>>              ac 02 80 00                                      ....
>>>          Extended Capabilities: len 10
>>>              Capability: bit 19: BSS transition
>>>              00 00 08 00 00 00 00 00 00 01                    ..........
>>>          Tag 262: len 1
>>>              1a                                               .
>>> Response: Connect (0x2e) len 4 [0x100]                              18.226572
>>      Status: Success (0)
So after this point is the issue. The kernel is sending no connect 
event, which will make IWD hang... We've seen this before with brcmfmac 
(maybe in a thread from you, but I can't remember). No idea how this 
could have happened without any changes, but since you were able to work 
around it with a separate guest network it points to something about the 
original network that brcmfmac doesn't jive with.
> Disregard.
>
> No idea what was going on. No amount of rebooting the device, dhcp
> server or router seemed to fix it. Was able to 'fix' it by enabling a
> 'guest' 2.4GHz SSID on the router then connecting the PiZero2W to the
> guest SSID. After this event, it started connecting to the original
> SSID. I even went and bought a new PiZero2W and tried connecting if it
> turned out to be a hardware issue on the Pi. The other 2.5GHz devices
> (thermostat and smoke detector) did not loose connection.
Glad its working now, very odd.
>
> Keith
>
