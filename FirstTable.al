namespace DefaultPublisher.Abschlussprojekt;
using Microsoft.Purchases.Vendor;

pageextension 50101 KreditorNachricht extends "Vendor List"
{
    trigger OnOpenPage();
    begin
        Message('Was gejht');
    end;

}