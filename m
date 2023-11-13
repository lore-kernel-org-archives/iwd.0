Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5041D1F60A
	for <iwd@lists.linux.dev>; Mon, 13 Nov 2023 13:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moCBQ+aV"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1cc1ee2d8dfso39076405ad.3
        for <iwd@lists.linux.dev>; Mon, 13 Nov 2023 05:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699881021; x=1700485821; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l8b5j2+hl25zI1xyj14IcLxUHw2aRQURkM9DwVe9t70=;
        b=moCBQ+aVhTimVFRgJ92wmz5dQV0UP9EbErVgAlgVtzrUVNY47eWnrFauhnMUfJaTJB
         MlyA2FGaiVRVQigzs/jU9jwPWUwDb8m2NSB8RXbhprkQ6Y1q8RFA6QfiHfwlH5S4doXs
         ig/EymHKQ2cuq0tBkDfyIUnkqayy6+m5yuZHbxzD5dYcnV2lsHoeGBvqWyhMPAXH32hc
         drAYkEfHZf3EvxcqQ6X7IeKDIEF2UBftxADH9IZkot3Bbb5OjptDYKoPuzZZIGioElfG
         kON9v9ZxMfJdrKdAI++K0j1vWBMs4ptfJ10auBJp7psIO6ewsL935cMvLBEysh71sNcU
         U+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699881021; x=1700485821;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l8b5j2+hl25zI1xyj14IcLxUHw2aRQURkM9DwVe9t70=;
        b=kIBdO5NiaMFZdq/sZ/srKSVJjAT2TUrJzDZJywfypVRoWhjyqETF7ivNPgPjcCnvST
         eR0BQkXbfQoQUh7BTuPPWSP5f/NebfPc3r/XouPTP6Ue8ye5m2z+Ck0jWqXOnOzobCFo
         9WdrPwuU20J5IM1Ar/gwg2E867WmTUK4raDPd+AR4GCAivWrxRtLoAV8MAGRQCOLaS5k
         kCMFHr6EGQu6TOH38Yr1nN8DgbDeygQiavr/JGyeed/OhY+o4qJYT5mE+UqkyUhNJraU
         +A/tWoVOkQzMqOWArcQ6WnL2bgGQ6h+55XgC7mFt9KiRkjEzIKWOHcZnxDiotuuQfTz0
         Aj2A==
X-Gm-Message-State: AOJu0Yxy+Y0BdFQiR/GrXg+b2FSeFKCLAxvtWAAsI/vquq6jFfNeYZSS
	AODsAxp0uxCq9FjtgQ7ANq8=
X-Google-Smtp-Source: AGHT+IHs1xzOKDXPprIdRyKMZYuQ0HyMCK0ZJ45sz8adyYawDC85o+E0QSyJRsf7fs0CmvKm+jt8VA==
X-Received: by 2002:a17:902:d2d0:b0:1ce:8e4:111 with SMTP id n16-20020a170902d2d000b001ce08e40111mr8196141plc.27.1699881021454;
        Mon, 13 Nov 2023 05:10:21 -0800 (PST)
Received: from [192.168.254.82] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id j18-20020a170902c3d200b001c728609574sm4012613plj.6.2023.11.13.05.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 05:10:21 -0800 (PST)
Message-ID: <4d8b889f-0b31-409b-93d1-7a06051adf9e@gmail.com>
Date: Mon, 13 Nov 2023 05:10:20 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] station: handle ROAMING state in disconnect event (again)
Content-Language: en-US
To: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>,
 Dimitrios Karnikis <DIKA@bang-olufsen.dk>,
 Claudio Cabral <CLCA@bang-olufsen.dk>, =?UTF-8?Q?Pedro_Andr=C3=A9?=
 <PEDA@bang-olufsen.dk>, Johnny Kudahl <JOY@bang-olufsen.dk>,
 "achyut.hegde@nxp.com" <achyut.hegde@nxp.com>,
 "yuvraj.singh@nxp.com" <yuvraj.singh@nxp.com>
References: <20230403141927.235014-1-alvin@pqrs.dk>
 <c9b5a931-ac35-2755-c656-acd567c1505f@gmail.com>
 <lrv3ytp7a6jvuupcu4pvx2w5jmud4yj6jxbk4imflcqeuosugo@vu7fco6auklk>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <lrv3ytp7a6jvuupcu4pvx2w5jmud4yj6jxbk4imflcqeuosugo@vu7fco6auklk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alvin,

On 11/13/23 4:46 AM, Alvin Šipraga wrote:
> Hello again James,
> 
> I'm resurrecting this old thread because we are hitting another roaming related
> issue and I am not sure whether the problem is in iwd or in the wireless
> driver/fw. I hope you can help me with some log analysis.
> 
> On Mon, Apr 03, 2023 at 03:35:28PM -0700, James Prestwood wrote:
>> Hi Alvin,
>>
>> On 4/3/23 07:19, Alvin Šipraga wrote:
>>> From: Alvin Šipraga <alsi@bang-olufsen.dk>
>>>
>>> The blamed commit clobbered the non-FT (Reassociation) roaming case
>>> in the disconnect event handler, causing iwd to potentially get stuck in
>>> the ROAMING state after a failed reassociation during non-FT roaming.
>>> Add it back.
>>>
>>> The subject is inspired by a previous commit which did the same thing,
>>> but introduced before the new roaming states were added, namely commit
>>> 8758cc89487b ("station: handle ROAMING state in disconnect event"). The
>>> rationale here is the same.
>>>
>>> Fixes: edf556cc7bb9 ("station: add two new roaming states (FT/FW)")
> 
> The last update I gave was on a silently dropped frame in the firmware when
> doing the 4-Way Handshake. This was fixed inside the vendor's firmware so there
> is nothing further to discuss there. See below for the current issue we are facing.
> 
>>
>> IIRC leaving out the old ROAMING state in this switch was actually done
>> intentionally. This is because netdev_reassociate() takes a callback and any
>> failures with the roam *should* show up in netdev_connect_event(), and in
>> turn call the callback which then leads to the same station_disassociated()
>> call. We wanted to avoid the potential of a disconnect event AND the connect
>> callback both calling station_disassocated().
> 
> OK, so this makes sense, but I think we are hitting an edge case in our test
> setup which slips through this logic. Allow me to explain.
> 
> We have an automated test setup with two BSSes in the same ESS and programmable
> attenuators used to simulate a low-RSSI event on the station. The sequence of
> events below begins with the station connected to the first BSS (BSS0), and it
> is expected that iwd will then direct the driver to associate to the second BSS
> (BSS1). This is without FT roaming.
> 
> 1. iwd receives a CQM event and enters roaming state.
> 
> 2. iwd issues a CMD_CONNECT. The driver defines .auth and .assoc ops, not
>     .connect, so it takes the SME path in the kernel.
> 
> 3. Auth/Assoc are successful and BSS1 kicks off the 4-Way Handshake.
> 
> 4. After entering eapol_handle_ptk_3_of_4() iwd asynchronously installs the keys
>     with CMD_NEW_KEY and then deletes the EAPOL timeout.
> 
> 5. The group key gets installed successfully (CMD_NEW_KEY returns success).
> 
> 6. In the mean time however the station receives a Deauth or Deassoc (not clear
>     from our driver logs) and the driver sends this to iwd. In
>     netdev_disconnect_event() iwd then follows this path:
>      -> netdev_connect_free()
>        -> handshake_state_free()
>          -> netdev_handshake_state_free()
> 	  -> netdev_handshake_state_cancel_all()
> 	    -> l_genl_family_cancel(nl80211, nhs->pairwise_new_key_cmd_id);
> 
>     Then, re: the original patch in this thread, iwd's station code ignores this
>     event, because the station state is ROAMING.
> 
> 7. The subsequent CMD_NEW_KEY then fails in the driver, but the above genl
>     callback is never invoked because it was cancelled.

Ok this does make sense to me. A disconnect from the AP could come in at 
any point during reassociation (during the ROAMING state). I think we 
assume the kernel handles this during the actual association step, i.e. 
relays this in the connect event, but during eapol/key setting I think 
your original patch holds some merit.

Just so we have public record I've sanitized the logs you sent (removed 
dates, hostnames, driver prints), and its clear that a disconnect at 
this moment would trigger this "Unexpected disconnect" case:

iwd[3589]: ../iwd-2.8/src/eapol.c:eapol_start()
iwd[3589]: ../iwd-2.8/src/netdev.c:netdev_link_notify() event 16 on 
ifindex 8
iwd[3589]: ../iwd-2.8/src/eapol.c:eapol_handle_ptk_1_of_4() ifindex=8
iwd[3589]: ../iwd-2.8/src/eapol.c:eapol_handle_ptk_3_of_4() ifindex=8
iwd[3589]: ../iwd-2.8/src/netdev.c:netdev_set_gtk() ifindex=8 key_idx=1
iwd[3589]: ../iwd-2.8/src/station.c:station_handshake_event() Setting keys
iwd[3589]: ../iwd-2.8/src/netdev.c:netdev_set_tk() ifindex=8 key_idx=0
iwd[3589]: ../iwd-2.8/src/station.c:station_handshake_event() Setting keys
iwd[3589]: ../iwd-2.8/src/netdev.c:netdev_set_tk() ifindex=8 key_idx=0
iwd[3589]: ../iwd-2.8/src/netdev.c:netdev_new_group_key_cb() ifindex: 8, 
err: 0
iwd[3589]: ../iwd-2.8/src/netdev.c:try_handshake_complete() 
ptk_installed: 0, gtk_installed: 1, igtk_installed: 1
iwd[3589]: ../iwd-2.8/src/netdev.c:netdev_mlme_notify() MLME 
notification Disassociate(40)
iwd[3589]: ../iwd-2.8/src/netdev.c:netdev_mlme_notify() MLME 
notification Disconnect(48)
iwd[3589]: ../iwd-2.8/src/netdev.c:netdev_disconnect_event()
iwd[3589]: Received Deauthentication event, reason: 1, from_ap: true
iwd[3589]: ../iwd-2.8/src/wiphy.c:wiphy_radio_work_done() Work item 15 done
iwd[3589]: ../iwd-2.8/src/station.c:station_disconnect_event() 8
iwd[3589]: Unexpected disconnect event

So I'm thinking we should merge the original patch adding ROAMING to the 
switch statement. Maybe Denis has some additional insight

Thanks,
James
